Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B6FCD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 20:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528C010F330;
	Thu, 14 May 2026 20:44:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.b="JD7aMel+";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E5010F330
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 20:44:12 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8b59772d441so84821516d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore.com; s=google; t=1778791451; x=1779396251;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
 :mime-version:message-id:date:from:to:cc:subject:date:message-id
 :reply-to; bh=iIn517qMFa/72Ee/XGTDeeK9Cq6VJiGDpV2GCDJOS7E=;
 b=JD7aMel++wt6XqXq202Zo5g5sssnnMRBNNnQ00EOnHPaPvQs1KJapHOW0tNJ7QHAoq
 eRuLrys0iwEn/Nwjb7dGzH/YTvGzUXLmn2xscrI/0yTIsL8BCYp3yTtGKvJDnq3gWd8z
 x1ILiEhYoVUhKFgofehWnh2qLN/u5PVABV7kqp0lVhv+KSSYdIJP1TA3xJzTnCpLa1HH
 DF4kM4/hrVRWWIlxOQm+gapLW6JA9WLXMH70BjioTocD/jmDRc7DuI6T2bV12GmU2O1r
 jRlebA6iLtbfxG2OnR6MQLPTufz85wPLEwRX0zdRrmfDoyJvLwnrnhPBE//iU0e1gMS2
 sGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778791451; x=1779396251;
 h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
 :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIn517qMFa/72Ee/XGTDeeK9Cq6VJiGDpV2GCDJOS7E=;
 b=Qk5CwbLSfrbACJbDQLfXHrtlSAoPRhD2YtXudiS8kUXklQMt54mMNL+ooPfWR5WBft
 PxD+AJw4SVx4s+6F4M/r/GI3zcma2ZyaHuFjjqZx4feQerGDqKDvOht7fFENOia2TOTG
 L35udT5HB78jmJ2hH3wwpDy2ZDaDlm/YtIsggMxRY/vB/0/bvLa+L3F2Kj56HuHhYdYw
 5/1Dgukwts820BxdqzAwZ+cHGakUndG/RtSHpL3lEw7a//eM3Bpd70jDoQS2daa7zPeg
 ipsaoBMkujT/2nXTTsXqoYpG3IX9KaqijbRwXd9NpQIvUI3vJLCGxMcTdWQaUUQLBiL/
 K6Jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8W+iwlVAsgdOlvsuAGj8MW2c/wsLWhVgqkuEAJiV10vu9cNxUlK3Xy3imnWQ2lnRAElY1B8rSjmXM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywi9grzfa9BB9uZtMV8XloQSLy0l4oDOxOVTR4Pj7pkXzIBvmq4
 nsw1yDMpeNbjBPDIKBcjZtTJixLjwlGJvi3MLgPsU2Hgg/lZHgpdiWkFBfIQvlp4pA==
X-Gm-Gg: Acq92OELnHYn7bWPzrJy1kri8m+DGWhka6E3WbsuvXuVxeFDTs4eTU/mFIR5ni2kSLr
 zdZx8fHX8Ao8j+ub0HTrHzAEwvkgrK++rNSwYHYIx2Ko5IQlEQskHdqJ8QZiupkih+YGgfNNfiu
 lJr3vLmXHsaSG7szxZuzTJeU+tasqX19AA5oGzqzTWbVc/QtZQiwMqFOLCQow1eCrJWRj7jjRTH
 TR/OTZmzfQUDnONm1TR6Y8uvqMtpZoeYYvnwznzi+nKDZs39XDQ5c965RhQRBZcYnJZv/Q+6SrW
 8F9oPemmqBer5Zo1XeIwUkp/8cse67pGgKEajaQnIdI3ZUwaj44aQdaBfqnJwnXn7M+5roLr918
 116wSAZkjFUwVzH8LDYaFXjBPNHe6bLJLuMt6WBywIwGrr2yYx0jyJSnU1tVBnaCfVbJBOOc6B3
 1F76dn/VG6Ss4q1cQIADs7PAsqJWBgE8i8/deH1JKAB8xQZeh+bzrzzBHYakeGUTm4wwmzI8ouJ
 yXaXmM=
X-Received: by 2002:ad4:5e88:0:b0:8ac:b70c:8a9b with SMTP id
 6a1803df08f44-8ca0f70f697mr20146116d6.44.1778791451056; 
 Thu, 14 May 2026 13:44:11 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net.
 [71.126.255.178]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90c358539sm32474826d6.41.2026.05.14.13.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 13:44:10 -0700 (PDT)
Date: Thu, 14 May 2026 16:44:09 -0400
Message-ID: <16093a0278a6d7d1a0a8bc055c228bed@paul-moore.com>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260514_1634/pstg-lib:20260514_1359/pstg-pwork:20260514_1634
From: Paul Moore <paul@paul-moore.com>
To: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Albert Esteve <aesteve@redhat.com>, mripard@kernel.org, echanude@redhat.com
Subject: Re: [PATCH RFC 4/5] selinux: Restrict cross-cgroup dma-heap charging
References: <20260512-v2_20230123_tjmercier_google_com-v1-4-6326701c3691@redhat.com>
In-Reply-To: <20260512-v2_20230123_tjmercier_google_com-v1-4-6326701c3691@redhat.com>
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

On May 12, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> 
> The security_dma_heap_alloc() hook allows security modules
> to control which processes may charge dma-buf allocations
> to another process's cgroup via the charge_pid_fd field of
> DMA_HEAP_IOCTL_ALLOC. Without a policy implementation, the
> hook is a no-op and the restriction is not enforced.
> 
> On SELinux-managed systems any domain with access to a
> dma-heap device node can therefore exhaust another cgroup's
> memory budget without restriction.
> 
> Implement selinux_dma_heap_alloc() using avc_has_perm() with
> a new dma_heap object class and a charge_to permission. Policy
> authors can then grant cross-cgroup charging selectively,
> for example:
> 
>   allow allocator_app_t client_app_t:dma_heap charge_to;
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  security/selinux/hooks.c            | 7 +++++++
>  security/selinux/include/classmap.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f704380a8c81..ea1f410b9f619 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2189,6 +2189,12 @@ static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
>  	return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
>  }
>  
> +static int selinux_dma_heap_alloc(const struct cred *from, const struct cred *to)
> +{
> +	return avc_has_perm(cred_sid(from), cred_sid(to),
> +			    SECCLASS_DMA_HEAP, DMA_HEAP__CHARGE_TO, NULL);
> +}
> +
>  static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
>  {
>  	const struct cred *cred = current_cred();
> @@ -7541,6 +7547,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(capget, selinux_capget),
>  	LSM_HOOK_INIT(capset, selinux_capset),
>  	LSM_HOOK_INIT(capable, selinux_capable),
> +	LSM_HOOK_INIT(dma_heap_alloc, selinux_dma_heap_alloc),
>  	LSM_HOOK_INIT(quotactl, selinux_quotactl),
>  	LSM_HOOK_INIT(quota_on, selinux_quota_on),
>  	LSM_HOOK_INIT(syslog, selinux_syslog),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 90cb61b164256..d232f7808f6b8 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] = {
>  	{ "user_namespace", { "create", NULL } },
>  	{ "memfd_file",
>  	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
> +	{ "dma_heap", { "charge_to", NULL } },
>  	/* last one */ { NULL, {} }
>  };

While we have seen some one-off patches to add specific resource/cgroups
controls in the past, much like this one, we've yet to see a patchset
that provides a more comprehensive set of resource/cgroup access controls
for SELinux.

I'm not opposed to a patch like this, but I would like to see it as part
of a larger effort to introduce access controls across all of the
existing cgroup control points where it makes sense.  In other words,
let's see a design for cgroup access controls so that we can ensure we
have something that is meaningful and makes sense from a policy
developer's perspective.

--
paul-moore.com
