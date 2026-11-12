Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8A8606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=M3lkLus9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B999C1120EC;
	Thu, 12 Nov 2026 12:55:52 +0000 (UTC)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com
 [111.22.67.139])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9D07710EB11
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 01:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=M3lkLus9smjsiQhWFEKg1vck4wPDNihJYeQrmawtfqGRqTRk8zHIFe8DQEETCv6iZbmmXdEtsYCzX
 IW+Nz1SwbLi4+ymD+qROHX4ThMxMKgW0aDMkkJ+78BbLG63Lqs65aKmxzKKYmZOumt9msJBmwe05vM
 LU3u5/ZbUyoAowl0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af518a4d25-d93f6;
 Thu, 12 Nov 2026 09:38:44 +0800 (CST)
X-RM-TRANSID: 2ee56af518a4d25-d93f6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [25.255.2.225] (unknown[10.55.1.70])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af518a3369-ed9c2;
 Thu, 12 Nov 2026 09:38:44 +0800 (CST)
X-RM-TRANSID: 2ee56af518a3369-ed9c2
From: Jiahao Xu <xujiahao@cmss.chinamobile.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 
 syzbot+369ee6a6e9d0bbf14b37@syzkaller.appspotmail.com,
 Jiahao Xu <xujiahao@cmss.chinamobile.com>
Subject: Re: [PATCH v2] drm/fbdev-shmem: don't warn on a transient dirty
 callback failure
Date: Thu, 12 Nov 2026 09:38:31 +0800
Message-ID: <20261112093831.384543-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <e16d5fb8-58bb-48dd-8f98-6777bd2fd2e3@suse.de>
References: <20261111124156.317053-1-xujiahao@cmss.chinamobile.com>
 <e16d5fb8-58bb-48dd-8f98-6777bd2fd2e3@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas,

thanks for the quick look.

> Cosmetic? Failing to allocate memory seems like a significant problem to me.

You are right, and "cosmetic" was a poor choice of words on my side.  The
allocation failure is significant -- what I meant is that the patch does not
downgrade it: the error is still returned to the caller unchanged.

What I am after is the drm_WARN_ONCE() call.  It fires for a failure that
userspace can trigger by writing to the fbdev fd under memory pressure, and
it produces a splat that panics with panic_on_warn and that syzbot turns into
a kernel bug report (extid=369ee6a6e9d0bbf14b37).  The same failure is
already reported to userspace through the return value, so the WARN does not
add any information that would identify a driver problem.

For the record, v1 got this wrong in a way that is worth keeping in mind:
with

	if (drm_WARN_ONCE(dev, ret, "Dirty helper failed: ret=%d\n", ret))
		return ret;

the propagation is gated on the value of the WARN macro, which yields 0 when
the warning is disabled, i.e. -ENOMEM was silently dropped.  v2 keeps the
propagation unconditional and only skips the splat for -ENOMEM:

	drm_WARN_ONCE(dev, ret && ret != -ENOMEM,
		      "Dirty helper failed: ret=%d\n", ret);
	if (ret)
		return ret;

If you would rather keep some diagnostics here, I am glad to resend with
either of these instead:

  a) as-is: keep the warning for failures other than -ENOMEM, propagate all;
  b) replace the WARN with drm_dbg_ratelimited()/drm_err_ratelimited();
  c) or drop the patch, if you consider the WARN appropriate in this path.

Which one would you prefer?

Thanks,
Jiahao


