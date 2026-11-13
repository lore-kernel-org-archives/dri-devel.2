Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CA606A331
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kPxoMAm3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YO7NQJk6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB135112801;
	Fri, 13 Nov 2026 20:57:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C88AB10E0F4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:57:40 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADKKT3j1314662
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=sO1cwZq9LHn0pDlrGqQpOhpfBJM8fi1Hf6WBVfr0ThU=; b=kP
 xoMAm3fRcab0Kbk51q7FFn55FiBzUAuq1i5LTeraB3kt5X7hl082HPDW2K/ysaQr
 0UQDcgmQNy0tZrXKp+GRNtOyXhxton+tKQr49RTofpYJlo6Hh261BFJJTbchT3uK
 3jORqMhpI2wrcwm3qBIfogD6LU9X/uZ7MjyBK6lXQwqKyqABXHo+9paBhRzjT8DT
 l5dwdbg5rW4+lK4laMPlcLjvv92jAqy36oW0JCQdt4BFiYXWpn+juKHEJpq04qid
 cAeIcZTriI9CN/ZvNrA5iflxqaCXhYCOjKaZHacS0bjv4XS8hpEV47Avcz+xWT3N
 IDQWlre0rJ68+dYmEtZw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwcuh4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:57:39 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-45e6091d8a1so927154fac.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:57:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794603459; cv=none;
 d=google.com; s=arc-20260327;
 b=HkjB7neilt8AypbUx5/5qHl5OG30V8S0qYuqyUnD/XFqDqgKOOZZEjzUZqTV74pYO5
 fXXyu6M1P7NR9IwPhOV+g7ya+GS9rzv2iOHo+9p1KbRHJMEI6D+DYHBDJyMtBxXhmO7P
 9fn02kqW9vhL0Ek4mqiEAOOml4wELZFZTba0swbU5V+PETbts2OiyR0yaC4kA3ut5xaa
 FUARXf2F3Yg4ysEwBOBjMVtqawgrniBjwBTNPDCXNt9yD5zphEcTWNcZyP3Zc42yZjMH
 2SiLPGl1LtdwnoBvXp1XcQThKi5G7cDIortWmH9Rzc1Co3e7ybh+hSFL0TLMGd4Y/lbO
 s0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=sO1cwZq9LHn0pDlrGqQpOhpfBJM8fi1Hf6WBVfr0ThU=;
 fh=4EPHS+mM5HZVZDFyoT/9EPETflS+3l0HPB6KI2oKldY=;
 b=AE+RrqUP7QOouJFQcoMaFvnyaBE0z3i27nMxFk16CKI1GmHupdONymOFjAUw/fNZOc
 yOS+ZvCrXckJnjisROZ/uyqJJtcH8cMCGmadWRS/ouZexU7G6TPbVDVAP86UzSRJmwJv
 4uVlSGspZ7r+uFQ3ZnptZqAWVHZxekhCGx7pw5JLkToJqLawym0mR8M0TX97EaANtMHZ
 ars6ZmEDTjMonVx4Vum8cIXHPhyWlrh8zUq1gMDXEgIibzTco8BUWNwB8dxFcCFIPmHg
 ERysthNsHomhVdoq0zVnRRK05gxw8Swga48yhcaCvz2JB9seNr95m68rlFSU8ruPDLZn
 m2rg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794603459; x=1795208259;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sO1cwZq9LHn0pDlrGqQpOhpfBJM8fi1Hf6WBVfr0ThU=;
 b=YO7NQJk6mDN+hernZ2nlEaBDaQunZjgboktAa9FPxUPMBuIOEusR4TuUZl4bh5IQf8
 pZu1ymLftaAIBowTsI2+q5c2+uuc24KWBiUU0XuRqMVo9gSgL0+1Z5qYqCMMXVeMJwXO
 +o5jdnWzszoZ1CA8JUXaePYC8PDG4I1LrPp/libVD0uWlcqnJbgjx0mcmBgx5Z5Zziv4
 Q2k+AvQGxzp+FCJPmrpdfUF85yAQJsyKlRkq8g+aJoaOEf9uDfhdYjnjj2eARfhtMpWF
 S0JvrKQ+MAjtK+NFkpKVXci5met07KJz9/w/F0iRdexplREmvwdW/Id5wt0t2L+1NHyB
 nteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794603459; x=1795208259;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sO1cwZq9LHn0pDlrGqQpOhpfBJM8fi1Hf6WBVfr0ThU=;
 b=r2EOa4B90AXa/k5biZJUiIlgvdeF4grirXJCO03W49zZJXyqYJU3rZBb9vnC7TLuZi
 y22lAAAmemRvFYeC8FAc9uqDtJYIs2gsjwzneIk1jHvH9inovcljE3/qMK5zbEXbC1Bd
 2OS4wYfWqqXcPXHOqEbB4YgnQ+p3JtVv4EDGtuNlQLpw7xtJmsl/LS+viLmI0+XPJlAS
 ijU1TK1FhFLA5KaeB5zPWpprhd04faFxw3O/snAd2knT7xFVtss1lNeGpLLIH6oCjKyr
 xqwHrepJKOZgE9mVW9J6xba19AuqyVZmi8drdRbvUSTbVZyS5enbE6zj3ih4Trzf6qRg
 GbgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHrY1DsiUAlOJgALqd2yejPRwZaBnz8FayCe8o6wCKupHLk7TwbtG8NvtDhk9xMUs4anyUnqBBX8BU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+i8ptXYbvWUaX4jYmKCg3PyqrfIIjWOBSALMmC9INsvQohf70F
 lgF3J9F1wXaZxzPKJgUX15JltUvIt6N3ClFmaRS4RepdSKClaYOVsMVtmgBIJ5lZk9QqY9DMa43
 ojxMML/OMjDs5RmGcp7BoKSuxFepJoUCVLE2b6WtjimZXQBcPeCYgC01B+VHMR0+LbuUUJwTQ8y
 2912rcC+4iahzStbltb3gx3PE57gWuj/s3xmShiZEwil/J3w==
X-Gm-Gg: AYBFou1nAOaKkGiqtbKUpDZMcnC5rZSgnSruT7tjiRlmJbkrNdq94vCeeJR/1KcBY4U
 hN5BO+2tvTJEEoFuMhB8xO/Ic/e7ys8cfinwXniCx2L4jPHazQVtxuU6mSnWmJzzfdzpiyZdYhl
 eEFSwWCe27tT02dDHkjet5ODA5a11j4yFIHzoTIyPH5Mstt5HMIyc2fDBrGxKLDxILgPBnaAR7O
 b4zLWTqUr6lWifP5DTc9A==
X-Received: by 2002:a05:6871:c914:b0:48f:e0e5:a1e0 with SMTP id
 586e51a60fabf-4afdf794eb8mr3593200fac.53.1794603458878; 
 Fri, 13 Nov 2026 12:57:38 -0800 (PST)
X-Received: by 2002:a05:6871:c914:b0:48f:e0e5:a1e0 with SMTP id
 586e51a60fabf-4afdf794eb8mr3593161fac.53.1794603458363; Fri, 13 Nov 2026
 12:57:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111080619.244138-1-julius@bairaktaris.de>
In-Reply-To: <20261111080619.244138-1-julius@bairaktaris.de>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 12:57:27 -0800
X-Gm-Features: AclHuK_jF12LGFMbl51Qw0skLNEfDBLsQfwj20MZJcl3WZZN4mMk_QEMp0swbqM
Message-ID: <CACSVV01-U9jEOfKsO8fgGtG_xQqjOF4TAKycJnqp4E-eDqsC2g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Keep objects of queued VM_BIND unmaps busy
To: Julius Bairaktaris <julius@bairaktaris.de>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af779c3 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=SXJYvs3pGg1A0ozdNicA:9
 a=QEXdDO2ut3YA:10 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-ORIG-GUID: Ali2IBXCZJwIYNGyqDaOHmqafVsTb05z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4MyBTYWx0ZWRfX0R52IgzFjyPJ
 mf0EpPoP0oLFktJEc3qJCPxvcNxqWcpwzySoxHhDsfOeZMMv2qj4oYHeoXtPyL061sNEFRUT+6N
 i9v7BckkyMhLobSCtW0ywsOWuC30gH9Dq06NIADSDygZPqbxh1ChHAc0HDkfoVFdNicOUAptFdl
 DJXGos8uy1gg+JmP2WOYEVhX6KEuqB2LJ4hq8ASHUKOzQy/zOhXtdOl30zfvjA9LPtMRz8UDeL0
 5PWFH2IBF7IvX3aB3fBTAawf+eYbd7TA4DXIZ0moE37JjAXyDAE1Ih33MhMrkpczyPU5iZc7KyG
 uBFBdOtUpJypY3Y8rPwZiHxmYN54HkHyFlZnY2mN0knL2+8HAZNlYsyVB6wTax/VGTzfvKKgLZK
 VWyAgS2LyTsEmH1aGMdLb0CyIkOhXksvk8YBEzOXd2WeycbWPn4XpEd2WWBVfD/i4SMm53vejKl
 PEgRXASFK2sR3kn174Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4MyBTYWx0ZWRfX3WNEDgFCslQL
 kr5ZW/12nxu9BvJd6eKzZ2ColwlSfa+MXEV32cidNtO6HnSdj4CSvpQEGbThClg7ALxypD2a3N/
 QvrYUEmf4ZFNob8Dh3U5hqNDp6GBZO4=
X-Proofpoint-GUID: Ali2IBXCZJwIYNGyqDaOHmqafVsTb05z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130083
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
Reply-To: rob.clark@oss.qualcomm.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 12:06=E2=80=AFAM Julius Bairaktaris
<julius@bairaktaris.de> wrote:
>
> A VM_BIND UNMAP closes the VMA when the ioctl runs, but the pgtable
> entries stay until the bind job runs vm_unmap_op(), and the job can wait
> on a caller-supplied in-fence for as long as the caller likes. In that
> window the unmapped object holds neither a pin nor the job fence:
> vm_bind_job_pin_objects() and vm_bind_job_attach_fences() only cover the
> objects named in the userspace ops, and an UNMAP op names none. The
> shrinker then sees an idle object and purges or evicts it, and
> put_iova_spaces() no longer finds the closed VMA, so the GPU keeps a
> mapping of pages that are freed and reused. The unmap half of a remap
> and a MAP that replaces a mapping take the same path.
>
> Reserve a fence slot on the object when an UNMAP op is queued, and add
> the job fence to it along with the fences of the mapped objects, so the
> shrinker treats the object as busy until the job has run.

Nice catch.. I don't really love that it means we can evict mapped
buffers but not ones pending unmap.  But so far I don't really see any
better option.

(Small note, a dma_fence should fire in a finite amount of time, or
TDR should kick in on the signaling side.  That ofc doesn't change the
issue here.)

BR,
-R

> Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
> ---
> I used Claude (Anthropic) to help write this patch.
>
>  drivers/gpu/drm/msm/msm_gem_vma.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 8b702422030af..d12df7e42fce8 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -473,7 +473,17 @@ struct op_arg {
>  static int
>  vm_op_enqueue(struct op_arg *arg, struct msm_vm_op _op)
>  {
> -       struct msm_vm_op *op =3D kmalloc_obj(*op);
> +       struct msm_vm_op *op;
> +
> +       /* Slot for the job fence, see vm_bind_job_attach_fences(): */
> +       if (_op.op =3D=3D MSM_VM_OP_UNMAP && _op.obj) {
> +               int ret =3D dma_resv_reserve_fences(_op.obj->resv, 1);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       op =3D kmalloc_obj(*op);
>         if (!op)
>                 return -ENOMEM;
>
> @@ -1419,6 +1429,8 @@ vm_bind_job_prepare(struct msm_vm_bind_job *job)
>  static void
>  vm_bind_job_attach_fences(struct msm_vm_bind_job *job)
>  {
> +       struct msm_vm_op *op;
> +
>         for (unsigned i =3D 0; i < job->nr_ops; i++) {
>                 struct drm_gem_object *obj =3D job->ops[i].obj;
>
> @@ -1428,6 +1440,17 @@ vm_bind_job_attach_fences(struct msm_vm_bind_job *=
job)
>                 dma_resv_add_fence(obj->resv, job->fence,
>                                    DMA_RESV_USAGE_KERNEL);
>         }
> +
> +       /*
> +        * The VMAs of unmapped objects are already closed, so the shrink=
er
> +        * no longer sees the mapping.  Keep the objects busy until the j=
ob
> +        * has removed it from the pgtables.
> +        */
> +       list_for_each_entry(op, &job->vm_ops, node) {
> +               if (op->op =3D=3D MSM_VM_OP_UNMAP && op->obj)
> +                       dma_resv_add_fence(op->obj->resv, job->fence,
> +                                          DMA_RESV_USAGE_KERNEL);
> +       }
>  }
>
>  int
>
> base-commit: 1e59855738454b14021b64115f0090eafc7526ae
> --
> 2.53.0
>
