Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA6606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 06:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EED10E2ED;
	Mon, 16 Nov 2026 06:29:08 +0000 (UTC)
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com
 [115.124.28.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD00A10E2ED
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 06:29:05 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07481378|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00795401-0.000598776-0.991447;
 FP=666744097143580335|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037034017;
 MF=wangxiaolei01@kaihong.com; NM=1; PH=DS; RN=12; RT=12; SR=0;
 TI=SMTPD_---.k2mszI-_1794810541; 
Received: from localhost(mailfrom:wangxiaolei01@kaihong.com
 fp:SMTPD_---.k2mszI-_1794810541 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 16 Nov 2026 14:29:02 +0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16afaa2ab+00dff8+gmail.com+wangxiaolei01@kaihong.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 14:28:58 +0800
To: <mwen@igalia.com>, <mcanal@igalia.com>, 
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, 
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, 
 <tvrtko.ursulin@igalia.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, 
 <stable@vger.kernel.org>, "Iago Toral Quiroga" <itoral@igalia.com>
Subject: Re: [PATCH] drm/v3d: Fix double free of query arrays when extension
 parsing fails
From: =?utf-8?q?=E7=8E=8B=E5=AD=9D=E9=9B=B7?= <wangxiaolei01@kaihong.com>
Message-Id: <e457d7c64cc913174affb10b272225cc3cbe88a3.b4134cc3.ce36.43c9.8ca3.6de341ddc6de@feishu.cn>
In-Reply-To: <20261110061341.2075931-1-wangxiaolei01@kaihong.com>
References: <20261110061341.2075931-1-wangxiaolei01@kaihong.com>
Feedback-Id: kaihong.com:1:all:larkmailservice
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Humble ping...
Thanks
Xiaolei
> From: "Wang Xiaolei"<wangxiaolei01@kaihong.com>
> Date:=C2=A0 Tue, Nov 10, 2026, 14:14
> Subject:=C2=A0 [PATCH] drm/v3d: Fix double free of query arrays when exte=
nsion parsing fails
> To: <mwen@igalia.com>, <mcanal@igalia.com>, <maarten.lankhorst@linux.inte=
l.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>, <=
simona@ffwll.ch>, <tvrtko.ursulin@igalia.com>, <wangxiaolei01@kaihong.com>
> Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, <s=
table@vger.kernel.org>, "Iago Toral Quiroga"<itoral@igalia.com>
> v3d_get_cpu_timestamp_query_params() and v3d_copy_query_info() - the
> latter used by both performance query parsers - free the query array on
> their error paths through v3d_timestamp_query_info_free() /
> v3d_performance_query_info_free(), but leave query_info->queries
> pointing at the freed buffer.
>=C2=A0
> The same job is then released by v3d_submit_cpu_ioctl()'s failure path
> (v3d_submit_cleanup_jobs() -> v3d_job_cleanup() -> v3d_job_put() ->
> v3d_cpu_job_free()), which calls the same helpers on the same
> query_info. On these error paths query_info->count was never assigned -
> it is only written after the parsing loop completes - so the syncobj
> loop runs zero times and no syncobj is put twice, but the
> "if (query_info->queries)" test still succeeds and the dangling pointer
> is handed to kvfree() a second time.
>=C2=A0
> Every failure inside the parsing loop takes this path: -ENOENT from
> drm_syncobj_find(), -EFAULT from get_user(), or -ENOMEM from
> kvmalloc_array() in v3d_copy_query_info(). The helpers are shared
> between that error path and the job release path.
>=C2=A0
> Clear the pointer once the buffer has been freed.
>=C2=A0
> Fixes: 0e50fcc20bd8 ("drm/v3d: Fix potential memory leak in the timestamp=
 extension")
> Fixes: 32df4abc44f2 ("drm/v3d: Fix potential memory leak in the performan=
ce extension")
> Cc: stable@vger.kernel.org
> Cc: Ma=C3=ADra Canal <mcanal@igalia.com>
> Cc: Iago Toral Quiroga <itoral@igalia.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Signed-off-by: Wang Xiaolei <wangxiaolei01@kaihong.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=C2=A0
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sc=
hed.c
> index 1924e3440dc9..a96023b5dce0 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -106,6 +106,7 @@ v3d_timestamp_query_info_free(struct v3d_timestamp_qu=
ery_info *query_info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0drm_syncobj_put(query_info->queries[i].syncobj);
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kvfree(quer=
y_info->queries);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_info->quer=
ies =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> =C2=A0
> @@ -122,6 +123,7 @@ v3d_performance_query_info_free(struct v3d_performanc=
e_query_info *query_info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kvfree(quer=
y_info->queries);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_info->quer=
ies =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0}
> =C2=A0
> --=C2=A0
> 2.34.1
>=C2=A0
