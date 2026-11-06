Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC7606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UHUNjpAV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 583A910FA9A;
	Fri,  6 Nov 2026 15:19:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FCDD10FA9A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793978373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6QE5LUaMLGNUcgDxlWZZglb/NRd2D5dLMiLzKGOWzQ=;
 b=UHUNjpAVm/IKE3rVqX0lXFgJ37DNAqsaC13IdL8cLhr4jrsbFy1vC9lIKISO2pc8PBPYjf
 FW72Q2n9F+Jtk/t+Rity2jmg+VL6nbWV6+ylvjauWVBXfu61blmXvfnJ5uFh3Z7I4roEsM
 Lx0eHsLJF/haKVz2RSxCJ8CsI0qSw5I=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-Kqgu7L8JO0egdLQAcUmKsQ-1; Fri, 06 Nov 2026 10:19:28 -0500
X-MC-Unique: Kqgu7L8JO0egdLQAcUmKsQ-1
X-Mimecast-MFC-AGG-ID: Kqgu7L8JO0egdLQAcUmKsQ_1793978368
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4cc89e86e9eso842512b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 07:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793978368; x=1794583168;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L6QE5LUaMLGNUcgDxlWZZglb/NRd2D5dLMiLzKGOWzQ=;
 b=kw8Y0oqU/SiwRQwvgGlxv2IGQHo3f+33wXzfqGBr1+ogJhpUUfN6vGS54S2prNM+5l
 KGJXfSM63Py2j0ZVpZkmnDLAb/ARrZTIfs3AFTcRmJqjUUzBZEO94svGUlhBHBfAZ7NK
 iZp62fIBrGwZ4iCjwiOKNicYFh8XpXJGShzpE4h6vMf7YU64y8TScJUKyykXuB38gtTD
 bkY+iZ1J95H/u2cmCWE0m1mj6Hh8/I8s88ya3wI0KL0kATH63VK1P6I5wD0Hkw1gmTSp
 QftKRtoPKw+fqAMOqI9989oqFBIqcNsbeM1QfMi0l3Otym81zwYhHqncKP3LPwpY1L2f
 p2vA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAUunVDWHyFOnwG8MCnk90QcfATKOSE6U50nvBgivOTeCjWAPAC7F8UHTng4wzjTmagdA+NC+ZRuY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+jQYCv+yGMw+l2yMYxphfDmHreJY0w8iJMObmeGGaGdL0zzEY2
 4iHkgn1vXQ5YWkUB8EwlxVdE7PJJV614vdIUk8Sk/RDHqzjd5uguhiV4FXuWLayIREgRQupbH6y
 SW6PILEVtWGPXMOn19ifx90JpWr7qG9Tanmtv6irtObr1ht628G/84sDf8PxybLn6HOeCFpRNZR
 CGrnBZ4gwjmVTJtq+NFB4hSudiQFfsrdeHwA/JMJaQQfP9
X-Gm-Gg: AYBFou2nDmnoOqg2bcWO/ovgX8YUphIZRk/vtRyqMz83AJQXQ9pJr28+UeqPMqzO4Tc
 b6ljXw/9iqeXh/D+V0tyj7iqH8BiQq1xVsA5eezTyBnknxLCrmIXQyTI+Q4NLjoDLrg53xjcOZD
 tSiX4fdgKiJalJrSAVmI8uFO+uVaIvsbDaDTv7+zeXqAIrMPN6CJ0ZV++5
X-Received: by 2002:a05:6808:6413:b0:4e9:3412:14ac with SMTP id
 5614622812f47-567e10ac541mr2034250b6e.33.1793978367817; 
 Fri, 06 Nov 2026 07:19:27 -0800 (PST)
X-Received: by 2002:a05:6808:6413:b0:4e9:3412:14ac with SMTP id
 5614622812f47-567e10ac541mr2034200b6e.33.1793978367246; Fri, 06 Nov 2026
 07:19:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-6-1819a017000b@redhat.com>
 <sashiko-outbox-198921@kernel.org>
In-Reply-To: <sashiko-outbox-198921@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 6 Nov 2026 16:19:15 +0100
X-Gm-Features: AclHuK_9kd4-vi33h14qEUizW5VOTBDWrh0Qg0FV14Te6uxs8q7OXuaFrYepPH8
Message-ID: <CADSE00LW0+EwEg8OBXUzZSkAu1-X=ofX5Dirq0+gbTTBUho6_w@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] selinux: Restrict cross-cgroup dma-buf charging
To: sashiko-reviews@lists.linux.dev
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
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _VsnZNLJi0rNFZtn6LzUyww1yLiQQh7pgmf4h0B8cdU_1793978368
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 12:12=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] selinux: one-off dma_buf class instead of general cgroup acces=
s control model
> --
>
> commit 675e985fff50ea6716b8c00023a75c07ff345a6f
> Author: Albert Esteve <aesteve@redhat.com>
>
> selinux: Restrict cross-cgroup dma-buf charging
>
> This commit implements the selinux_dma_buf_charge_task() hook and adds a
> new dma_buf object class with a charge_task permission in SELinux to
> restrict cross-cgroup dma-buf memory charging.
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 30776b0107f29..8f39d91eabc97 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2204,6 +2204,12 @@ static int selinux_capable(const struct cred *cr=
ed, struct user_namespace *ns,
> >       return cred_has_capability(cred, cap, opts, ns =3D=3D &init_user_=
ns);
> >  }
> >
> > +static int selinux_dma_buf_charge_task(const struct cred *from, const =
struct cred *to)
> > +{
> > +     return avc_has_perm(cred_sid(from), cred_sid(to),
> > +                         SECCLASS_DMA_BUF, DMA_BUF__CHARGE_TASK, NULL)=
;
> > +}
> > +
> >  static int selinux_quotactl(int cmds, int type, int id, const struct s=
uper_block *sb)
> >  {
> >       const struct cred *cred =3D current_cred();
>
> [ ... ]
>
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 90cb61b164256..b4ebedc6e4240 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >       { "user_namespace", { "create", NULL } },
> >       { "memfd_file",
> >         { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } }=
,
> > +     { "dma_buf", { "charge_task", NULL } },
>
> [Severity: Medium]
> As reported by Paul Moore on RFC [1], adding a one-off SELinux object cla=
ss
> and permission for a specific subsystem's cgroup charging (previously
> dma_heap with charge_to, now dma_buf with charge_task in secclass_map[]
> and selinux_dma_buf_charge_task(), along with charge_cgroup in a later
> patch in this series) introduces a narrow, subsystem-specific policy clas=
s
> rather than a general cgroup and resource access control model for SELinu=
x.
>
> Although resolving the target memcg from charge_fd moved into generic
> memcontrol code in mem_cgroup_get_from_fd(), the SELinux hook in
> selinux_dma_buf_charge_task() and class definition in secclass_map[] stil=
l
> define a dma-buf-specific class instead of a broader cgroup access contro=
l
> abstraction.
>
> Should this permission check be designed around a general cgroup or resou=
rce
> SELinux object class rather than a one-off dma_buf class?
>
> [1] https://lore.kernel.org/r/16093a0278a6d7d1a0a8bc055c228bed@paul-moore=
.com

I held off on this so the core charging proposal could settle first,
and then refine the LSM side later / in a separate series depending on
the feedback.

For v5 I'm adding a capability baseline in mem_cgroup_get_from_fd()
following a Sashiko report, so that charging a memcg outside the
caller's own subtree requires CAP_SYS_RESOURCE. With that in place the
LSM hooks no longer act as the only check, they add finer-grained
policy on top of it. Also, unlike the RFC, they are now called from
generic memcg code rather than dma-buf code, so I should have renamed
them (and plan to) to security_memcg_charge_{task,cgroup}().

Regarding the broader cgroup model, as far as I can tell, existing
cgroup control points are kernfs file operations, which SELinux
already covers. The only non-file operations taking a cgroup fd (i.e.,
BPF attach and perf cgroup events) use their own subsystem classes.
Since remote charging in this series consumes the target cgroup's
resources, checking against the cgroup's label (as patch 7 already
does) sounds like a good fit.

So to Sashiko remark and Paul's comment, rather than a dma-buf
specific class, would something like a "cgroup" class with a
"charge_to" permission for the cgroupfd path, and a process (process2
really) permission for the pidfd path, be an acceptable first step,
with the class growing as other non-file control points come up? I'm
happy to adjust the naming or structure to what works best.

BR,
Albert




>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_20230=
123_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D6
>

