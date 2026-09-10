Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779FDC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEFEC10E590;
	Thu, 10 Sep 2026 08:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Of6a4gkp";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8EC10E590
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:44:16 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-86a31708876so217721b3a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789029856; x=1789634656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hTyYRl2YZ/oM02ctlIcPWPHMCgn8HGs1uC6kTHGWSeM=;
 b=Of6a4gkp1pqp2Mt7rCwjMJI0FMFHb1bTVM9Jfgif/ElfMtwRm4kKBJbOawKV3V4cZS
 csEICoi1/NPdpCCDZxQlg2pp0vEcb6yGIysnBa7hiK1xZLRdP4MDOZoOuZo1G7yV3Pht
 XsNKOu+fEp3uYyndkEqwmXOzjuIzQaWd0l6auid5k9B5KfoAxPBxietKgdM+bZew+FAZ
 7kv5/mrgqQHSzLF06NhVVV5e5cdpFclaJPEItYZA23ZPiYv+bW+jOPtUjds5ANGTonEv
 wHjbcSB6gELMbLvVh1mWmhfQu5q4LWoWX26uzte7wTVEqrpnNC0KfXmlchsCW9DT2f4W
 L2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789029856; x=1789634656;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hTyYRl2YZ/oM02ctlIcPWPHMCgn8HGs1uC6kTHGWSeM=;
 b=kEdG5y6sngEhgst0w1Zdjh9n5VcPnr1UrSLHGjNn0x7b4JwQ/l9ppbkMi+PaON72pW
 YPzsPq1WuNzHI/GNybmCoFQth4nt+0Q2kRJbitfNDUdLVHKqBiaRNUzEW2gH1lqCEkyW
 Jp/UWdHMyaTnWVQmJfwTLKbjilrceR7SbqgokjI/p3+unduLdOUWxQkgjUlK8hVvMZ76
 5JnLEWAoqAm8/c5svx+eDN43SCKKAVOYcI37tgmoyw+62ZLPY0x/TgzUgCncOPDMIe6N
 Fep2u/8/JY7L2knCUfmuqDKnOfdpG8HStt13XEksGOP2uJEqx4C9fRvOXUbU+Uha/2G4
 wSfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBNB8A6ivQNeUY1c/ofUHXDZ+R0zrYZASFcNEcm67WvDQUsH9olgR8cgquQpML+zOcLpAzlveRqnY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kUL7/6O4Yl9hB5In2H2KkXBXcYPGiIwjbKTrAn7qM1O3Cakmm0
 Jysd+yBl/9fxOM7qa+kJM0UpQFJ1mqGS9wns53fRH9MFsQVGenhAwHE=
X-Gm-Gg: AYBFou2GWVMBWAKNX1QlqjsVdSWgpqP7i8kGDOsgYK2WOJA8OciKcix8cOE0ihILOJg
 sb0QjzUrL+p1pDORl4SRc6cz+FOynoBFCB2ZUBS5K91ehQBZPm6BSbbJ74SSNKUrp+MsXm/+LTT
 9fBkmQ7Il+xHZRA6jR+FLA+OKbmsClJ/Dy1g8me06doGmMBcIR8QZ+L2CnjOleWhddsKuXW3PGP
 /PcChYr2kQ0KTURbnQfZSfYMsz2homuYVM+g2HAF9ZP1bxMgeap9WLJDpJNMgRHQxBPG9ktS+zG
 fqs6gyjWsTOvNh0L4ghmhir+IsspbLcKIr/8UhNJfieZRW7bhv4jWRycJbYRwlCpA54ZWyDr4l2
 ccPgUp6edGNJ26sYCxQPLOwMB2MrfPVIGsaq4D3nl+6VPoBD4hZtrvxLFD60DEgqjKXFQvUNJzL
 4bNSiOrlf4liHKnC3U0QmVA8J+zfj4XxggSm6o6OnkzGRPSgz7YVbLx5Z8rmpaEvGmlLBEuEKc3
 6zPrVjotyoBN+L5NcLRpi/sRA==
X-Received: by 2002:a05:6a00:181c:b0:85f:b00b:8760 with SMTP id
 d2e1a72fcca58-86168f83f7amr53037833b3a.5.1789029855475; 
 Thu, 10 Sep 2026 01:44:15 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA
 ([2001:2d8:7f04:fd2a:f01d:1dc7:1e5:47d8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86153728c37sm7968329b3a.46.2026.09.10.01.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 01:44:15 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 phasta@kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Philipp Stanner <phasta@mailbox.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: drm/sched: run queues freed before the TDR that drm_sched_fini()
 waits for
Date: Thu, 10 Sep 2026 17:44:08 +0900
Message-ID: <20260910084408.703333-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <df7b0d1e-5a74-445b-90fe-fae30cee4cb3@amd.com>
References: <20260910054605.634135-1-donggeunyoo.kernel@gmail.com>
 <6f52dcbb040b8ba796b56311e9a77465d111c868.camel@mailbox.org>
 <df7b0d1e-5a74-445b-90fe-fae30cee4cb3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 9/10/26 09:32, Christian König wrote:
> Amdgpu shouldn't do that any more.

Correct, and I should have checked before writing it - 182bdd59be41
("drm/amdgpu: deprecate guilty handling") removed it. The callers left are
etnaviv, lima, panfrost and v3d. v3d is the one I should have named.

> That was an extremely ugly hack applied long long time ago because amdgpu
> was broken at that time and didn't waited for
> drm_sched_entity_flush()/drm_sched_entity_fini() before calling
> drm_sched_fini().

Understood, I am dropping that half of the argument.

> No it doesn't. You quoted the wrong code, this is what really matters:
>
>         drm_sched_wqueue_stop(sched);
>
>         for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++)
>                 kfree(sched->sched_rq[i]);

I am not sure I follow this one. If the point is that
drm_sched_wqueue_stop() has already quiesced the users of the run queues
by the time the loop runs, I cannot find where it covers the timeout work:

	WRITE_ONCE(sched->pause_submit, true);
	cancel_work_sync(&sched->work_run_job);
	cancel_work_sync(&sched->work_free_job);

work_tdr is queued on sched->timeout_wq and is only canceled by the
cancel_delayed_work_sync() below the loop, so a timeout handler can still
be running while the run queues are freed. Is there something else that
rules that out? And if I have misread your point, please elaborate.

On how I got there: the KUnit case never signals the hardware fence, which
is what keeps the handler inside timedout_job() while drm_sched_fini() runs.
That breaks the rule that all run_job() fences are signaled before
drm_sched_fini(), so a correct driver should not reach this, and I have no
reproducer that does not cheat that way. The same caveat is in the patch.

I am writing up the patch Philipp asked for. The only change is moving the
kfree loop down beside kfree(sched->sched_rq); no new code.

Regards,
Donggeun
