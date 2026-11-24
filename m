Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F0606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=yd3tzZ4m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B10110FA07;
	Wed, 25 Nov 2026 08:42:19 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B6310E880
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:50:12 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so48698235e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795528211; cv=none;
 d=google.com; s=arc-20260327;
 b=kn/MFZuMicJLfRup03psRDXiNQlb5THFbB4yLIKSoMwFPPadD5qH21J/E0iDR6beey
 YEhtg8Q+/cD83DUAQxrRdGeQkuUjqTEKbCTERzHy2RB/byVfwIG3Iu+/5lBPfj52iF9C
 Rf8piA5AAiIGrGi5QNqFXTw28LpbkqIdHJnU23vQXSjMQXLPIP8818N+E5qrsMNWoMDx
 EnUni1072m8+up2oJs4VHaY9bMpXOqhfQVNiyXamBgzrXeMO6pfIbyAcnS99llZ/TGky
 2rrwnRl2Cm9m2nCqdxypewkp2+sqBHN5eEYlKwDvpViOwVZXL9wTLo7ejw55GVk1t+Na
 4Lww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
 fh=wXSfdlN5ljy1pNHNYINh/z5fP355Z30Nz7gXyzwcJho=;
 b=SMxrb63VaYCl+GymnprBPk39XsChhBviaBmWFxsd04EebrIBC49pIy2ZVM2nnAuAQZ
 Ydq2TA4ZEbj12t9zy9e6wqQPyFCb05UEVPvsf87I/iAiCiF2Z6Gpr7qWwsxfNHhsphx/
 nrkOC7Q54aKgOPIIhto8CKrwLRmqRMbq7Cyu7IlnRO0C4cjdlzkcnYGop2QSkCynp7Oi
 NdwkESyarq+iyKwBxENYht2DOP/YbgDdmpLUePhWeRTMXT+2ZWZJllg+SML3thjgrTfX
 jW9w5DU7IKRGMmDp0XtoWI1jfyxVKwt4lVZjtKYoSvI4aDl9OiralVpghAawSXz+18B/
 9/qw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20260707; t=1795528211; x=1796133011;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
 b=yd3tzZ4mT53MVZYYmvEhv9T2lEiAlDD+rdXnbBAIPEYtzj5UpLZ+QGTtgwEx3sW1wf
 W5W9AaYu6D3VLy3ww7NxkKuMb4zywIW1YB8p7f07Zv+6SpPoL7sGC0LS/wQ9XHJn/a5G
 fAhPONU/kVjQTpZ5vuFvStiiWyLOf8lFSmyhNF8ojvm8cqcdEVnq9Weg2sFrvjCBzD3u
 QYp4ciPs+uGSYL2sOOWRpQSi0l8lf6TkPzPtzbsna6Z8LA+8XMu/T/qk03tIePMVDNJV
 4vkWRSKDFSfIhCl2YMmSAxIIMOgQbJIlqKNRsDDElIHRVN5xBK+gHM/BFMdb3oF+yi0h
 SDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795528211; x=1796133011;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
 b=XCX2QOWjhS4CshP8GC6sVGa0I3xKPgSYTQwMuFIXEtyvrhTovHHRQSbexHvqRzNvuA
 NxSp/cc47uh4HxYWfIVQc8MuHq1xFVUmc5LN2pl172UOoopAXznqPSbakbCEl7iv+N25
 exEgnFi8MBEe2nbtSjHCDiZvZjj//codY39acriy2oWWarjIfdRxm+VRMN8GUoEpxC1d
 hRELW1rFyHVtQ+zWfOUEN2ULN4YAbFT7Mta3p8QOX9cIkIsSglzmGyt1AvBdItUSltHu
 +1T0+zvRdcXLrNQiAYQu9miriycc0aLAzvfahiak5ZkhH4B58d7//VLeiWwyWtXhWqRA
 w9tw==
X-Forwarded-Encrypted: i=1;
 AL+hErFl3W8x+KbhhRjikjMnuuYytovZdMsV4PgO0iK+1Wnlv42UtKLmzXQ/0Ng1+5LKTL/yZQkhpbBy0Io=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/sB7WNw5F9IuMCRij0gqZE1VFip4vs39wVmci8AB+YFn4MD1NO
 VtSGVB6B1GWvWSoYnS1HGM0e7+rEIflfv8dI5bWWB/fnBVcNcICKvhzFf0UIp99FLi/7aGOUTkh
 eBZHAh8CXpwNvyjJxuHdT+jk5QnTNkcI=
X-Gm-Gg: AZFdTZe5umh3gGdfsZDx+wpt6XJ1uzIbxA8x4YQVeHtGNTj1bNhaGvNLS2Y/iImQKTw
 QqCuOxkUgFWRVGZvGcELQAQuq8T0cXSWIw6Sdudoi+IKbptVaeNRi73zOivE0fRF3/cRoNlVYAY
 AMVT//e2PeY8GHC0nluLtZ31w3Pc8G3hIwTk516qBv2+i7SN3F6SsYNBCCu+tBhF7cfqc2HcY1z
 5Ms/5/BE55MofR+iVdsg0CI3EKL2iqdB5vM2YO/ALxM9AZLOHqOMTeKJam/8F8f3+DmunOsqugM
 4Ywi1jqd+ELu8LxOk7J45SIhnXzVXnSzQ1LeQ79e+prhBrtPoMst5ULZqAXKc+V4Eu+68EyaP1r
 KwvKI021/zqmVVMJ/XKHhv7e4xFMIXVoAkwetrjRbaWAy6iUdgBXu
X-Received: by 2002:a05:600c:800e:b0:4bb:7757:fe58 with SMTP id
 5b1f17b1804b1-4bb8881b9d7mr305306125e9.19.1795528210579; Tue, 24 Nov 2026
 05:50:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com>
In-Reply-To: <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 24 Nov 2026 14:49:55 +0100
X-Gm-Features: Aa3M54qkPJ8C4GRzLQzCC_QtBShd4rpGnT89RPbtOkkrzzkAiMVQPjTTZfQmmls
Message-ID: <CAJ2a_DeDF+9pbLKS9pcX4Tot4xZZ-K7HydKnDjW6TWC5bvREzQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] selinux: Restrict cross-cgroup memcg charging
To: Albert Esteve <aesteve@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
 echanude@redhat.com, mripard@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 14:05, Albert Esteve <aesteve@redhat.com> wrote:
>
> The security_current_memcg_charge_task() and
> security_current_memcg_charge_cgroup() hooks allow security modules to
> control which processes may charge or transfer memcg memory to another
> process's cgroup, named by a pidfd, or to an arbitrary cgroup named by
> a cgroupfd, both passed in charge_fd. Without a policy implementation,
> either hook is a no-op and the restriction is not enforced.
>
> On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
> domain that holds both dma-heap access (today's only exporter that
> opts-in) and that capability, can charge memory to any cgroup outside
> its own subtree. Since the capability is all-or-nothing, SELinux
> policy cannot express which targets such a domain may charge to.
>
> Implement both selinux_memcg_charge_task() and
> selinux_memcg_charge_cgroup() using avc_has_perm() with a new cgroup
> object class and a new charge_to permission. Both charge_fd flavours
> ultimately charge a cgroup, so one permission covers them and the
> target type keeps the distinction: for the pidfd path the target is
> the referred task's SID, as there is no cgroup object to take a label
> from; for the cgroupfd path it is the cgroup directory's inode SID,
> which comes from the genfscon entry for cgroupfs unless the directory
> is relabeled.
>
> The checks run when the charge target is resolved, before the
> CAP_SYS_RESOURCE baseline is evaluated, and apply to every explicit
> charge_fd target, including the caller's own subtree, so policy needs
> a rule even for self-charging. Policy authors can then grant
> cross-cgroup charging selectively, for example:
>
>   allow allocator_app_t client_app_t:cgroup charge_to;
>   allow allocator_app_t cgroup_t:cgroup charge_to;
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  security/selinux/hooks.c            | 19 +++++++++++++++++++
>  security/selinux/include/classmap.h |  1 +
>  2 files changed, 20 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6c4c64d6e904..76a714107ae4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2204,6 +2204,23 @@ static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
>         return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
>  }
>
> +static int selinux_memcg_charge_task(const struct cred *to)
> +{
> +       const struct cred *cred = current_cred();
> +
> +       return avc_has_perm(cred_sid(cred), cred_sid(to),

Small nit:
`cred_sid(current_cred())` could be simplified using `current_sid()`

> +                           SECCLASS_CGROUP, CGROUP__CHARGE_TO, NULL);
> +}
> +
> +static int selinux_memcg_charge_cgroup(const struct file *file)
> +{
> +       const struct cred *cred = current_cred();
> +       struct inode_security_struct *isec = inode_security(file_inode(file));
> +
> +       return avc_has_perm(cred_sid(cred), isec->sid, SECCLASS_CGROUP,
> +                           CGROUP__CHARGE_TO, NULL);
> +}
> +
>  static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
>  {
>         const struct cred *cred = current_cred();
> @@ -7683,6 +7700,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>         LSM_HOOK_INIT(capget, selinux_capget),
>         LSM_HOOK_INIT(capset, selinux_capset),
>         LSM_HOOK_INIT(capable, selinux_capable),
> +       LSM_HOOK_INIT(memcg_charge_task, selinux_memcg_charge_task),
> +       LSM_HOOK_INIT(memcg_charge_cgroup, selinux_memcg_charge_cgroup),
>         LSM_HOOK_INIT(quotactl, selinux_quotactl),
>         LSM_HOOK_INIT(quota_on, selinux_quota_on),
>         LSM_HOOK_INIT(syslog, selinux_syslog),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 90cb61b16425..1f1f2fc4d35d 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] = {
>         { "user_namespace", { "create", NULL } },
>         { "memfd_file",
>           { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
> +       { "cgroup", { "charge_to", NULL } },
>         /* last one */ { NULL, {} }
>  };
>
>
> --
> 2.55.0
>
>
