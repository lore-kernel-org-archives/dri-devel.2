Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86317606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 03:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E847F10E55E;
	Thu, 19 Nov 2026 03:21:49 +0000 (UTC)
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com
 [115.124.28.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE4210E55E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:21:47 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0743626|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0208611-0.00067148-0.978467;
 FP=649024642764358883|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033045038069;
 MF=wangxiaolei01@kaihong.com; NM=1; PH=DS; RN=12; RT=12; SR=0;
 TI=SMTPD_---.k5UwiSa_1795058502; 
Received: from localhost(mailfrom:wangxiaolei01@kaihong.com
 fp:SMTPD_---.k5UwiSa_1795058502 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 19 Nov 2026 11:21:43 +0800
Date: Thu, 19 Nov 2026 11:21:39 +0800
Subject: Re: [PATCH] drm/v3d: Fix double free of query arrays when extension
 parsing fails
From: =?utf-8?q?=E7=8E=8B=E5=AD=9D=E9=9B=B7?= <wangxiaolei01@kaihong.com>
Feedback-Id: kaihong.com:1:all:larkmailservice
In-Reply-To: <c8e13d27-7d16-481d-82bf-6f7cca80a5e4@igalia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Message-Id: <e457d7c64cc913174affb10b272225cc3cbe88a3.c95b4073.de9e.4f90.800a.f434468c5368@feishu.cn>
To: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: <mwen@igalia.com>, <maarten.lankhorst@linux.intel.com>, 
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>, 
 <simona@ffwll.ch>, <tvrtko.ursulin@igalia.com>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, 
 <stable@vger.kernel.org>, "Iago Toral Quiroga" <itoral@igalia.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16afe6b44+bc14d3+gmail.com+wangxiaolei01@kaihong.com>
References: <20261110061341.2075931-1-wangxiaolei01@kaihong.com>
 <c8e13d27-7d16-481d-82bf-6f7cca80a5e4@igalia.com>
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

Hi Ma=C3=ADra,=C2=A0

Sorry for the early ping =E2=80=94 I overlooked the "wait at least a week"
guidance in submitting-patches,

> From: "Ma=C3=ADra Canal"<mcanal@igalia.com>
> Date:=C2=A0 Wed, Nov 18, 2026, 21:22
> Subject:=C2=A0 Re: [PATCH] drm/v3d: Fix double free of query arrays when =
extension parsing fails
> To: "Wang Xiaolei"<wangxiaolei01@kaihong.com>, <mwen@igalia.com>, <maarte=
n.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, =
<airlied@gmail.com>, <simona@ffwll.ch>, <tvrtko.ursulin@igalia.com>
> Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, <s=
table@vger.kernel.org>, "Iago Toral Quiroga"<itoral@igalia.com>
> Hi Wang,
>=C2=A0
> Please, be patient with kernel maintainers. Kernel etiquette recommends
> waiting at least a week before pinging maintainers [1].
>=C2=A0
> On 10/11/26 03:13, Wang Xiaolei wrote:
> > v3d_get_cpu_timestamp_query_params() and v3d_copy_query_info() - the
> > latter used by both performance query parsers - free the query array on
> > their error paths through v3d_timestamp_query_info_free() /
> > v3d_performance_query_info_free(), but leave query_info->queries
> > pointing at the freed buffer.
> >=C2=A0
> > The same job is then released by v3d_submit_cpu_ioctl()'s failure path
> > (v3d_submit_cleanup_jobs() -> v3d_job_cleanup() -> v3d_job_put() ->
> > v3d_cpu_job_free()), which calls the same helpers on the same
> > query_info. On these error paths query_info->count was never assigned -
> > it is only written after the parsing loop completes - so the syncobj
> > loop runs zero times and no syncobj is put twice, but the
> > "if (query_info->queries)" test still succeeds and the dangling pointer
> > is handed to kvfree() a second time.
> >=C2=A0
> > Every failure inside the parsing loop takes this path: -ENOENT from
> > drm_syncobj_find(), -EFAULT from get_user(), or -ENOMEM from
> > kvmalloc_array() in v3d_copy_query_info(). The helpers are shared
> > between that error path and the job release path.
> >=C2=A0
> > Clear the pointer once the buffer has been freed.
>=C2=A0
> This is indeed a bug, but the solution doesn't fix the ownership problem
> here. We should actually leave the cleaning process to
> v3d_cpu_job_free() instead of cleaning it in the parser. I wrote this
> draft of what I was thinking on:
>=C2=A0
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c=C2=A0
> b/drivers/gpu/drm/v3d/v3d_sched.c
> index f29d79b15be3..15bec1e35e39 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -96,17 +96,18 @@ v3d_sched_job_free(struct drm_sched_job *sched_job)
> =C2=A0 }
>=C2=A0
> =C2=A0 void
> -v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_inf=
o,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int count)
> +v3d_timestamp_query_info_free(struct v3d_timestamp_query_info *query_inf=
o)
> =C2=A0 {
> - =C2=A0 =C2=A0 =C2=A0 if (query_info->queries) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int i;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int i;
>=C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < coun=
t; i++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 drm_syncobj_put(query_info->queries[i].syncobj);
> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < query_info->count; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!query_info->queri=
es[i].syncobj)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
>=C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvfree(query_info->que=
ries);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 drm_syncobj_put(query_=
info->queries[i].syncobj);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 kvfree(query_info->queries);
> =C2=A0 }
>=C2=A0
> =C2=A0 void
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c=C2=A0
> b/drivers/gpu/drm/v3d/v3d_submit.c
> index eada30a31701..a3e92e097423 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -734,7 +734,6 @@ v3d_get_cpu_timestamp_query_params(struct drm_file=C2=
=A0
> *file_priv,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_v3d_timestamp_query timestam=
p;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct v3d_timestamp_query_info *query_=
info =3D=C2=A0
> &job->timestamp_query;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;
> - =C2=A0 =C2=A0 =C2=A0 int err;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!v3d_validate_cpu_job(file_priv, jo=
b))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIN=
VAL;
> @@ -747,7 +746,7 @@ v3d_get_cpu_timestamp_query_params(struct drm_file=C2=
=A0
> *file_priv,
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0job->job_type =3D V3D_CPU_JOB_TYPE_TIME=
STAMP_QUERY;
>=C2=A0
> - =C2=A0 =C2=A0 =C2=A0 query_info->queries =3D kvmalloc_objs(struct v3d_t=
imestamp_query,
> + =C2=A0 =C2=A0 =C2=A0 query_info->queries =3D kvzalloc_objs(struct v3d_t=
imestamp_query,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0timestamp.count);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!query_info->queries)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENO=
MEM;
> @@ -758,32 +757,22 @@ v3d_get_cpu_timestamp_query_params(struct drm_file=
=C2=A0
> *file_priv,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < timestamp.count; i++)=
 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 offset,=
 sync;
>=C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user(offset, o=
ffsets++)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 err =3D -EFAULT;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto error;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user(offset, o=
ffsets++))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return -EFAULT;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_info-=
>queries[i].offset =3D offset;
>=C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user(sync, syn=
cs++)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 err =3D -EFAULT;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto error;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (get_user(sync, syn=
cs++))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return -EFAULT;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_info-=
>queries[i].syncobj =3D=C2=A0
> drm_syncobj_find(file_priv,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sync);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!query_info->queri=
es[i].syncobj) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 err =3D -ENOENT;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 goto error;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!query_info->queri=
es[i].syncobj)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return -ENOENT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_info->count =3D timestamp.count;
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> -
> -error:
> - =C2=A0 =C2=A0 =C2=A0 v3d_timestamp_query_info_free(&job->timestamp_quer=
y, i);
> - =C2=A0 =C2=A0 =C2=A0 return err;
> =C2=A0 }
>=C2=A0
> It doesn't even compile, it's just a draft to give you a more concrete
> example of what I'm thinking on.

And thanks for the pointer on the ownership problem =E2=80=94 you are right=
,=C2=A0
the parser should not be the one releasing the arrays. Following your
draft, I'll rework it so that v3d_cpu_job_free() is the only place that fre=
es
them: the parsers will just return on error, ->count will be published
before any entry is filled (so a partially built array is still cleanable),=
=C2=A0
the arrays will be zero allocated, and the same treatment will be
applied to the performance path and to all of the parsers, not only
the timestamp one. I'll send a v2 once it builds.

thanks
xiaolei
>=C2=A0
> [1]=C2=A0
> https://docs.kernel.org/process/submitting-patches.html#don-t-get-discour=
aged-or-impatient
>=C2=A0
> Best regards,
> - Ma=C3=ADra
>=C2=A0
> >=C2=A0
> > Fixes: 0e50fcc20bd8 ("drm/v3d: Fix potential memory leak in the timesta=
mp extension")
> > Fixes: 32df4abc44f2 ("drm/v3d: Fix potential memory leak in the perform=
ance extension")
> > Cc: stable@vger.kernel.org
> > Cc: Ma=C3=ADra Canal <mcanal@igalia.com>
> > Cc: Iago Toral Quiroga <itoral@igalia.com>
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Signed-off-by: Wang Xiaolei <wangxiaolei01@kaihong.com>
> > ---
> > =C2=A0 drivers/gpu/drm/v3d/v3d_sched.c | 2 ++
> > =C2=A0 1 file changed, 2 insertions(+)
> >=C2=A0
> > diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_=
sched.c
> > index 1924e3440dc9..a96023b5dce0 100644
> > --- a/drivers/gpu/drm/v3d/v3d_sched.c
> > +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> > @@ -106,6 +106,7 @@ v3d_timestamp_query_info_free(struct v3d_timestamp_=
query_info *query_info,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 drm_syncobj_put(query_info->queries[i].syncobj);
> > =C2=A0=C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvfree(q=
uery_info->queries);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_info->qu=
eries =3D NULL;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0 }
> > =C2=A0=C2=A0
> > @@ -122,6 +123,7 @@ v3d_performance_query_info_free(struct v3d_performa=
nce_query_info *query_info,
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0=C2=A0
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvfree(q=
uery_info->queries);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0query_info->qu=
eries =3D NULL;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> > =C2=A0 }
> >
>=C2=A0
