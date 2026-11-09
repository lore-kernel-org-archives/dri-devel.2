Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB8D606A332
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NFgfbiwC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AOLkFupe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC4010E2AA;
	Mon,  9 Nov 2026 22:45:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E562710E2AA
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 22:45:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9L9tYJ435351
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 22:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=fazzd23XuqkczbJhKe+9++OyaNsMKZLfRujVe7uBMk4=; b=NF
 gfbiwCqucCQIhNyCQ0Baw1Pni2GDajRidGKROS2z7kjLLu8d4aBOA8atlRRxLxcD
 UrwOSA+aAlrA7Ya9ZCWjha9w7BqQUULyp6l3LylfC6qXRVNYmYW0Yqm4dAh4tGfC
 dRobK82aLzJSD99N+Fo6UekbzDH+aQpNoFR2A6YOptRK78JBI5aNG+NDg2YK9c6w
 YHyjhtnxXoPS3KioKaqX7m6l+xabQ3yUw87Sw3kqzCiFWm0zCkZ0ILspHlpDJNRx
 mlA0eQm+6f5pw36lfb2GIf+s7c3c6LRxZjtnCBwxMIdCyXvYqBsDRLBEhWQ6b3DK
 D9S76qqOgzEMobkxgv0w==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcjabd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 22:45:30 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-70b8894d6c1so1642224eaf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:45:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794264329; cv=none;
 d=google.com; s=arc-20260327;
 b=g9f5R4aaNIj9RR06lgiMjRrDI92VvITvWqOLcuJ1jWE6ArxOLfGuhjxEZRYtlZ/1+L
 BAqgFiYKqSHV7LmPS30+DzCBv+G9CTnlSVr5MS/lBlbLAMT7kSBSgbnF8nlM/6pqFXIr
 sItt7Bl1YKm8DxpOG8kxl0ERax2G8pAuLAucck87Y+MOwg5vb2D2ANwQkeLeZ7FbsLdg
 qipdiH+widYOLFGD2JYgWmi/UHZxLX2POEIdtZaacDPBHXuGz6FS416w8Gg0133sfvve
 1HvE5AhhS6P0oMjYzjLcTPfUR48I8r8DSy7Fzrv67GE16UC+gXpqJgKmr/N9C7LYGza5
 sHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=fazzd23XuqkczbJhKe+9++OyaNsMKZLfRujVe7uBMk4=;
 fh=UPD8xKskLAJQByJV4KLks5pnNndVBaX/mdyCW/ysqtA=;
 b=HD3UkIq8QbW9gofHAAFMJUt/pfTqUZkrWbsGl42G5df+OA39XyzU9aGc0JzLTZbiXF
 ArHGWL0hGaq/GpomLNb4NmwKAPnZRPIabdWdozvxA2gSXiEOkGSePdxJLOZbk3NEUPfl
 9/60koyModwhMCvh/OBCJNmaXt32khJzhSKCbpU6Cku0eBdDeBjCGY8TUSbpiRd0+RVs
 DX4e81RKhC+mBywQrW7+KqY1hxvCAbxqK/li2sxpTPAGiS8LvnuPulAkalAAdP/rz0st
 2RhBEsptuFyjkjxkFfAMatHB1QDglNRBZRvuDfIARBMffUvLyKwAhxYdANql7cyh8Qhc
 4S1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794264329; x=1794869129;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fazzd23XuqkczbJhKe+9++OyaNsMKZLfRujVe7uBMk4=;
 b=AOLkFupe8BBW8XmHRqPvFDqwHlSCvpAo2ZKT95asFPNCJqOMgHlxP71CvjQioBB6hG
 /4Poa1pVz5REaHdnIZzD6LvNooV79pLc6AjHHJLF2hlOQ9xjTNN7g+GrDnpF+GGhnZH4
 7/FoBh4NqbXBvHwxZd+9eMfdYaz34+8qSY7ZBXihV36fLbTrrc/ryX1vzvv8K1iJBHyi
 9V2ZI//wAxisDeWqU53ZQrkByKXbz2mtF6tC9EqcGZo3W89DU55EIoAYk99F7KhJ4h1m
 ihIGPrAH1Do8qt/MDP0GFSCufrNwTJ8a5Ajc1G5M/mbTPALs7p45B1a1pTJ12SXfjRwp
 eUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794264329; x=1794869129;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fazzd23XuqkczbJhKe+9++OyaNsMKZLfRujVe7uBMk4=;
 b=WS48QDSzM06NB8Vmrg/PGiivMyIwH1ZkZYd+99Jh2w9sw2IrjuMyMHgdmS6GUFuoB/
 5JjmQ/GardFbdl/+UF2tTm8nuNM+4Jv1zYZOINZzDAuhVAOmTSym90WfS16bUSPefJOY
 AhhOJrAnlXFBkqoKe5teFdiGDlwu9j3wqit6yBHf9Cs1rLmoxa5bcFMeypQ296UIWOXc
 Ifna9MHcT4FtHC7HSROjDQotRFjPvpZ9gHtT6MzfSSKDQ1JFE1VWzyIc/Uip9ed9bT1h
 1HOeD770f5quVC0evONl4859HPlBTlkuE/jyaeni2A3m6Tr7p1Ckq9dIAH8+nEXWZW4Q
 146Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEk06X/O+tz6TnXXryT9pe/mkW3YWSmeFJpFWym+Wg3VXBBISrTwKTp1IVprTeThoTxm/PLB+UfrkU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9e1J0r4kpv5V4saw8udlN4taxdW5wyKTBHhxR65ec4SL+f6Uwf
 Dizng5I59VFS0A8tff7ZD7piqum30O+O+229EFWP+UL32476weMaWTYkm03qc97r2KXHuYCzB9g
 XntYY3vLBLUl+YcOF21qWP26/ZojcrQSuKPydUirSUYgYKLfyO728Jwy0iIFNR7cRGuj6/aZxy1
 f+GDBv5D/y9UM+zbirliDBWyxB+2JIKogRhDdewFqRKFSiVQ==
X-Gm-Gg: AYBFou3omQDLszQ5jPEvHdWEP9VVdUCI22C1cC7AE4tVskEVerAePUPpABqsmOqBZ+Y
 rnx9VxcqflQ/RrWwV/oUR3I0zG+zXmNJCvXfGXHlZEw6loz3q5CYfN0heqOt86UlwWPvUrsdzKw
 orkth/SpQXT6hqKeDbKHDf1SUSsMRZjZ3IWK2tIxJNZ+JSPZ8a2EOICz4H7uI/h6ISWNIOteapM
 Tpgb2mcJLtKY/YhrdOEPw==
X-Received: by 2002:a05:6820:807:b0:70b:8cd5:8925 with SMTP id
 006d021491bc7-7189943f411mr493678eaf.12.1794264329464; 
 Mon, 09 Nov 2026 14:45:29 -0800 (PST)
X-Received: by 2002:a05:6820:807:b0:70b:8cd5:8925 with SMTP id
 006d021491bc7-7189943f411mr493668eaf.12.1794264328974; Mon, 09 Nov 2026
 14:45:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-msm-va-align-v1-1-2e9b576d2e4e@gmail.com>
In-Reply-To: <20261109-msm-va-align-v1-1-2e9b576d2e4e@gmail.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:45:18 -0800
X-Gm-Features: AclHuK_svB21z8Zydd-btaDPqYjJTLzzkRcg1ZIp2xV-hHnPyAoFyw35lJK_YnE
Message-ID: <CACSVV00paci9M7mkvNoqTjTupBCE6=Sw5VxrDca0n1NdSXLfNA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: align kernel-managed GPU VAs to 64 KiB
To: gauravsuman007@gmail.com
Cc: Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: LmSVPkc20Aq9r5al-yjWIuMrZkpVuBq2
X-Proofpoint-ORIG-GUID: LmSVPkc20Aq9r5al-yjWIuMrZkpVuBq2
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af24d0a cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8 a=ZpVaWaFtAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=5wWQRGSUZCY4pMmLUQ0A:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22 a=Vxmtnl_E_bksehYqCbjh:22 a=5tn4MO8azEBWFjlAA-rn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MCBTYWx0ZWRfX1rC+LapBQrI/
 nTYmkwBC9R8gS2KZIZ1LvvOayx8K5CDnrdgkxhBMhzZjAoH3Nx9CxlAhS76EOjkGazzlcedaDIK
 pByAB4DrOX1G61iIRhTg/CYPYDaLlxo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MCBTYWx0ZWRfX75KRsiciuG8v
 0OUP98km07TCVUgeJlgv+Zxddv+5TMF0opC1ltsCqwDhHlYNPV5TFgNI5rVi3ZU2yS20NFXyVAI
 qoV4nqvpD8qibCGvlRZcoXwv6Z81mHBYRC2bfadt2ZNHMXKPmnLMLHxqnNDnJYaqQcN+0fl1kHu
 4tPMzoS0MdgTnL2dKYGSIam2YXPeAzayplAQ/bx08NVRTkucqiVNTgN8Q1JqZdZPzqgy1+Bx23O
 wpXyyYBsuZeE+1C8VgVMBoEkMLeqaT/Cv15bS8SrZYuUPvlGoYWGuBI4Z1V9EgRMBPba3kJmTYk
 BcPMR0yLYNWbyo5JCEtrKrEkaIOeI8iV/bl5yRMMyFTFSNKdguLRBdqPy0zabcK3yXCmeggCmqO
 K2rjr7macLLu6hvLhMSAYbJRdikx3wRdQFA3cPxYC3OK7NEGknfyv8Bco/EjeHNZTrGGWOgMuWG
 VU0B5J99SsKQmpXGybg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090090
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

On Mon, Nov 9, 2026 at 2:34=E2=80=AFPM Gaurav Suman via B4 Relay
<devnull+gauravsuman007.gmail.com@kernel.org> wrote:
>
> From: Gaurav Suman <gauravsuman007@gmail.com>
>
> On an Adreno 640 (SM8150, LG G8x) GNOME Shell triggers SMMU
> translation faults with source=3DCCU, about ten per login, when
> freedreno uses GMEM (binning) rendering. FD_MESA_DEBUG=3Dnogmem or
> =3Dinorder hides them.
>
> A stall-on-fault capture decoded with crashdec shows the faulting
> address at an exact 64 KiB boundary (FAR 0x110690000) while the pass
> drew to MRT0 at 0x110695000 and depth at 0x11069f000, all in that
> 64 KiB block. The block start belonged to the unmapped tail of
> another buffer that was not part of the running submit. A ring
> buffer of pagetable operations confirmed this for every fault: the
> CCU reads the 64 KiB-aligned start of the block holding a bound
> render target, and msm packs kernel-managed VAs at 4 KiB, so that
> address often belongs to a different, unmapped buffer. Batch
> reordering makes this common, which is why inorder hides it.
>
> Align kernel-managed VAs to 64 KiB, falling back to page alignment
> when the range is too tight (a6xx_gmu_init() fails with -ENOSPC
> otherwise).
>
> Tested on the LG G8x with Mesa unchanged and GMEM enabled: in an A/B
> run in one boot, 4 KiB alignment gave 10 and 10 faults per login, 64
> KiB alignment 0, 0, 0 and 0. No faults in three further logins, a
> GMEM stress test or the full device test suite; glmark2 is unchanged
> within noise. Userspace-managed VMs (VM_BIND) are not changed; Mesa
> may want the same alignment there.

This seems like it is papering over a userspace bug..

Could you file a bug on mesa gitlab[1] and attach a GPU devcoredump[2]
after an SMMU fault?

BR,
-R

[1] https://gitlab.freedesktop.org/mesa/mesa/-/work_items
[2] https://docs.mesa3d.org/drivers/freedreno.html#gpu-devcoredump

> This was investigated, written and tested with the help of an AI
> coding assistant (Claude Opus 5.5, Anthropic); I reviewed the change
> and the test results.
>
> Signed-off-by: Gaurav Suman <gauravsuman007@gmail.com>
> ---
> Tested on LG G8x ThinQ (SM8150).
> ---
>  drivers/gpu/drm/msm/msm_gem_vma.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index f687a629629d348b54ebb379d3a2fa956b8e472e..2af43291289945d54326287af=
feffa7e72645880 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -388,9 +388,20 @@ msm_gem_vma_new(struct drm_gpuvm *gpuvm, struct drm_=
gem_object *obj,
>         if (vm->managed) {
>                 BUG_ON(offset !=3D 0);
>                 BUG_ON(!obj);  /* NULL mappings not valid for kernel mana=
ged VM */
> +               /*
> +                * On a6xx (seen on A640) the CCU can read the 64 KiB-ali=
gned
> +                * start of the block that holds a bound render target. A=
lign
> +                * kernel-managed VAs to 64 KiB so that block start lies =
inside
> +                * the buffer itself; callers with a tight fixed window, =
such as
> +                * the GMU, fall back to page alignment.
> +                */
>                 ret =3D drm_mm_insert_node_in_range(&vm->mm, &vma->node,
> -                                               obj->size, PAGE_SIZE, 0,
> +                                               obj->size, SZ_64K, 0,
>                                                 range_start, range_end, 0=
);
> +               if (ret =3D=3D -ENOSPC)
> +                       ret =3D drm_mm_insert_node_in_range(&vm->mm, &vma=
->node,
> +                                                         obj->size, PAGE=
_SIZE, 0,
> +                                                         range_start, ra=
nge_end, 0);
>
>                 if (ret)
>                         goto err_free_vma;
>
> ---
> base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
> change-id: 20261109-msm-va-align-072b585038aa
>
> Best regards,
> --
> Gaurav Suman <gauravsuman007@gmail.com>
>
>
