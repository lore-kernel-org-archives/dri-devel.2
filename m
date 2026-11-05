Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABD606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d/anUTjw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T3cGhQJv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207A910E39F;
	Thu,  5 Nov 2026 21:31:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A5610E3AC
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 21:31:33 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L6IBj1586322
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 21:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K+yyAmjtjcPT4PKxalvzle5QlVUS80uiwYOMk1MKomU=; b=d/anUTjw0BuTJt7B
 8gBjnXaoMWgDu8QzI+gZ+BtVULG5BC9iZfDsLJSsKUvDQx58nJFGtxoYm1L8vvZS
 M2/DvdygoaY4vDVmmnwbiej+1s65CqAAay9veESKqyzmVsuYmzLovulsSpHOh+K1
 sEZkYUes1mhsGt/BYQAAJOfuthQphFhDT7XdoWe+thdzTzosplJ1dWYmCVu9LH9I
 jj6W3QZU9ckKRJrZNtjYR5JdUZDWtxJbI4DhAwR7sWEukkHxO5ryqokCpSLnSc76
 +AxSN9zZiCXDx2TQxCAnydo2SVrJsKFA0qVaP2TXeJiQ9IXRhGHfX55+hRT37iRj
 VHn+Cw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs0wg87rj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:31:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36cec75d8caso1296eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 13:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793914291; x=1794519091;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K+yyAmjtjcPT4PKxalvzle5QlVUS80uiwYOMk1MKomU=;
 b=T3cGhQJvr1yViWWe+Vl1CU48QMUZ/XPmPCr9pYHdjlgeNxORSeO4QO0/3/eq6UTK6I
 Vl7GzG5ACKtTotVNgpcRyf1iMYomPf6QYGAkr8CAs2KNMQgG7VzUVf5IlEYeqYm/HrAn
 XGWdiiEN8DOi/AGOjKoekSjqlZgxhRFpxYgekswbHjuj+9jFd56TaUeXZhbkUR6eiW4e
 zX0ZOIcmOJHtvHlf0mDAtHxvLJHGFXTQxQAbYWHQonR6Mo+kScpPe3zuUpVB5VTgZUTU
 yePSbfBp3SLsuWV1m4tmE8w+FcmTZi0NI0ulc96P5puLgfBpNItXko/T6n+lGvuzk/KU
 n2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793914291; x=1794519091;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K+yyAmjtjcPT4PKxalvzle5QlVUS80uiwYOMk1MKomU=;
 b=TFwEWMDUXxu0bzeTQ3bKNRjMF82bD8jaBP6PM3c7/xKLnG0OTBBlB4pCIdGPCqkIwo
 8yer7m0D0uty9LOlkKbfpEP+/Xb5bJC7ZgrqPguJkLetxBIw8yTd9bwYOBNmdqla6vGe
 543MVWrI8NpINlgAHtTGbVtFTeVqgy46tTe2eX16iCiqvemJvVbTGTAFEZA3NS5DPEy2
 mkyayxXqPkxKrSqQGgvQGJOSCwX9h+DtnAOpraE52Uea3Bmgzb1CQFDRLa9jXwjNNpHK
 gar5jbFHDvMs/86AQ02By8VMpyx0mpzkg6cldaH8S02K30M/LLY1lxYLLUtH4+HA3E6O
 ydog==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1DxXFKoI0s10/xxOxR+wmtYd/6STMXVHBaKiJ5JYADk6e9iGvzLSfd5qWjorJ3VIExbDgzZcpyl4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8V+BVThUyIT7JmQ49kU1FLGMofbTF6k2wXoEKR6bSbgQekCMOj
 5bJ009gGlz+nSs7F62o2zJFlIrO6chJP3J6/y8Riq/UbF8okohjnAeZOCX+AJm0KUSFtlNO8ycN
 Lv+Or3MJoLWM0ySGRBSAMrW6yG21JeDChl+UNoGAOFc7pIAET3cQ3X2/moC6zLEVdU24JMQU=
X-Gm-Gg: AYBFou3NssKSmSeIkik6dyno3fHVbrDxzZqjN3XE7srSQJRg20qdfOYRbEXhP/ndgrc
 FzCQfE4NkF5o5YqpmW0S9Y0KK8sb5DYSCipJd+0aQQ3IQlbEGOQiudH8l1WsANTjik91LbZRCOW
 CDUR3It71kOy+JYobS9oWKKNtgHgDbBBbXOAC03DzvYZfN216rJv3EY11fzJ3eWtJiczDipY8dL
 sG4rOSVuIZDtJnJDhj3LCHL1TtrTvq51Ifst+YD44Ami8Y/QkE0v3VxnlmoyLgkVok8KLft6lqI
 SNIL58RhR0bwuiCaKtEVeqA12Sm6NG27o/+aYdmOZWYGfw7BFfbGcxifP7SqEEW1ABLqnTCLVFh
 ZppXLbceCg3JPAJKrN3nNa4EolKyn+AXRF1of86Empim6QvuadheZAW/Kq6j7cjPgCvDy74U=
X-Received: by 2002:a05:7301:5412:b0:36d:158c:e31d with SMTP id
 5a478bee46e88-36de6d4cca9mr5494586eec.18.1793914290970; 
 Thu, 05 Nov 2026 13:31:30 -0800 (PST)
X-Received: by 2002:a05:7301:5412:b0:36d:158c:e31d with SMTP id
 5a478bee46e88-36de6d4cca9mr5494536eec.18.1793914290179; 
 Thu, 05 Nov 2026 13:31:30 -0800 (PST)
Received: from [192.168.1.9] ([106.222.231.155])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f72fbe241sm1023706eec.10.2026.11.05.13.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 13:31:29 -0800 (PST)
Message-ID: <e1c19166-9abd-4a35-b532-a3287bfe7607@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 03:01:23 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/15] drm/msm/a8xx: GPU state capture support
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wX3U4HQKO3X3CdMwvB8KiL0HEHRzQ-d9
X-Authority-Analysis: v=2.4 cv=Ka9HIgYD c=1 sm=1 tr=0 ts=6aecf5b4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Hj0ah+TxS5FywmoD0uLh0Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=y5CuoXqKkQWRv-GPwuMA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NSBTYWx0ZWRfX/oeOkoyvOkJP
 sD+lIIQnan6EhnFqe6JZ2Vl5s4ne0oPlRjvX1TgkmI2bJO4UOvSN3rGSLt7TkWICYQmleFhYKJG
 8V4dEegIJoDQMyNtEMMhLRyNe2VRJ1EjmAge1eMrcZrAXAQrcyRvU3AXnMcs8MpROv6yCf/OBjq
 /KbtMYYTsS6y9lO1LSSnEWPO6esEfTZ2Vs8JfjrwZCt9wZJFLccDjRPbubbLsoP0HYJ8pR7FXEu
 p0ObXvgM+Qxi9xb4szruLS+D0EGz9d1nqCV3VPs+SpyoefO5IK0kRCZrHcMy3dfb1k4+Bav8JE8
 hk3I2L3Qh6eaQYVlxY+f5+QQi7+T3h0lSgh4suXcWQdqix9fxaXRIkJik6IgV4pBlO88n+vEojp
 ldpb3Gy0MbLF3PaLnsJdOMecPiaPp7bIphSsGGDe4bOlHyeXVitY02dzDzKH7Xv8madCHiH3zY3
 SmzxRvrf2SiOIVdQLnA==
X-Proofpoint-GUID: wX3U4HQKO3X3CdMwvB8KiL0HEHRzQ-d9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NSBTYWx0ZWRfX8DX/u7f+IJRZ
 QBbIrm5nQYkPxagUy4vYQMGmJZJ+O3U7ALZbXM8iPRZ8zDa7gtbvAawlMjzxN28rhthIbMalAX5
 faIsu5/ZQ6uMbfQeSBIUkLN/lFhvE/s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050085
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/2026 1:59 AM, Rob Clark wrote:
> This series introduces gen8 devcoredump support.  Compared to previous
> gens, it:
> 
> 1. Switches to generated tables.  Compared to hand modifying headers from
>    kgsl (which were originally generated, then adjusted a bit by hand before
>    adding to kgsl tree.  And then copied to drm/msm and lightly modified
>    some more in the process).
> 
>    In the process, we also switch to generated cp_protect tables.
> 
> 2. Aligns to the "snapshot" format that kgsl/etc use for hw state capture.
>    The non-generation specific bits (SMMU fault info, capturing relevant
>    BOs, etc) still works as before.  Everything gen8 specific gets encoded
>    as "snapshot" sections, ascii85 encoded in the resulting devcoredump
>    file (similar to captured BOs).
> 
> 3. Try to make it easier to at least compare kgsl snapshot code with
>    upstream, for porting fixes/etc.  State capture is tedious and mind-
>    numbing, and the last thing you want to do when debugging a GPU hang
>    is going down the rabbit hole of having to first debug gpu state
>    capture.
> 
>    However, I don't love kgsl_snapshot_add_section().  It does avoid
>    duplicating snapshot header stuff everywhere.  But the ergonomics
>    are not great.  So instead I went with "align with what I wish kgsl
>    looked like..
> 
> The mesa/crashdec side of this is at:
> 
>    https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/45304
> 
> I'd appreciate tested-by's on Hawi, Maili, Milos, and Pakala, since I

I will help with Hawi and Maili.

-Akhil

> don't have these devices at-hand to test myself.  To test devcoredump,
> you can use the msm_recovery test in igt.. or just:
> 
>   cat /sys/kernel/debug/dri/*/gpu > /dev/null
> 
> NOTE: I'm still tracking down some descrepancies compared to kgsl.  I
>       think at least we should be matching on the excluded access-
>       protected regs, so hopefully collecting a devcoredump doesn't
>       make things go boom.  Tested on glymur (windows fw) and on
>       kaanapali MTP (android fw).
> 
> NOTE: Uses $codename for generated file/table names, rather than continue
>       to perpetuate the equally meaningless gen8_x_y naming from kgsl into 
>       upstream.  At least the codenames are familiar upstream and this
>       removes an extra level of name translation.
> 
> v6:
> - Fix gx_is_on() check
> - Only capture preemption records if preemption is enabled
> - Link to v5: https://lore.kernel.org/all/20261102220405.30730-1-robin.clark@oss.qualcomm.com/
> 
> v5:
> - Fix inverted IS_ERR_OR_NULL() check
> - Drop IFPC fixes (moved to their own series)
> - Link to v4: https://lore.kernel.org/all/20261030211928.45761-1-robin.clark@oss.qualcomm.com/
> 
> v4:
> - Drop RB_GC_GMEM_PROTECT from nonctx list, now that we are computing
>   the value directly
> - Add missing 'break' in switch
> - Move RBBM_MISC_STATUS read to after we check GX is on
> - Rename sysprof_setup
> - Add cleanup.h support for disabling IFPC, and use it in debugfs
>   snapshot path
> - Collect tags
> - Link to v3: https://lore.kernel.org/all/20261029201730.151754-1-robin.clark@oss.qualcomm.com/
> 
> v3:
> - Drop generated nonctx list for now
> - Exclude access protected registers
> - Shuffle around some debugbus blocks to match kgsl
> - Use CP_PROTECT_PIPE regs to pickup the extra spans if we exceed the
>   64 CP_PROTECT_GLOBAL regs
> - Inhibit IFPC for gpu debugfs dump
> - Fix cx_dbgc capture
> - Misc other small fixes
> - Link to v2: https://lore.kernel.org/all/20261021204244.67160-1-robin.clark@oss.qualcomm.com/
> 
> v2:
> - Fix incorrect protect list for Kaanapali
> - Use __free() for snapshot_sect finalization
> - Fix missing early return error path in gen8_snapshot_mempool()
> - Fix aperture setting in gen8_legacy_snapshot_mvc()
> - Fix first_slice in gen8_snapshot_mempool()
> - Remove GBIF regs in generated nonctx list
> - Link to v1: https://lore.kernel.org/all/20261020204728.28844-1-robin.clark@oss.qualcomm.com/
> 
> Rob Clark (15):
>   drm/msm: Import adreno_snapshot.h
>   drm/msm/a8xx: Export aperture helpers
>   drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
>   drm/msm/a8xx: Export slice helper
>   drm/msm/a8xx: Add missing a850 ifpc reglist entries
>   drm/msm/a8xx: Allow nonctx reglist to include GMU regs
>   drm/msm/a8xx: Stop getting GMEM_PROTECT from nonctx list
>   drm/msm/adreno: Fix PROTECT span length
>   drm/msm/adreno: add temporary __maybe_unused
>   drm/msm/a8xx: Import generated headers
>   drm/msm/a8xx: devcoredump state capture support
>   drm/msm/a8xx: Add all CP_PROTECT_PIPE to pwrup reglist
>   drm/msm/a8xx: Use CP_PROTECT_PIPE regs
>   drm/msm/a8xx: Switch to generated protect regs
>   drm/msm/adreno: Remove temporary __maybe_unused
> 
>  drivers/gpu/drm/msm/Makefile                  |    4 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |    7 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   14 +-
>  drivers/gpu/drm/msm/adreno/a8xx_catalog.c     |  404 +--
>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c         |   65 +-
>  drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c   | 1403 ++++++++++
>  .../gpu/drm/msm/adreno/adreno_gen8_snapshot.h |  576 ++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h       |    2 +
>  drivers/gpu/drm/msm/adreno/adreno_snapshot.h  |  530 ++++
>  .../drm/msm/adreno/catalog/adreno_glymur.h    | 2307 ++++++++++++++++
>  .../gpu/drm/msm/adreno/catalog/adreno_hawi.h  | 2387 +++++++++++++++++
>  .../drm/msm/adreno/catalog/adreno_kaanapali.h | 2317 ++++++++++++++++
>  .../gpu/drm/msm/adreno/catalog/adreno_maili.h | 1882 +++++++++++++
>  .../gpu/drm/msm/adreno/catalog/adreno_milos.h | 1977 ++++++++++++++
>  .../drm/msm/adreno/catalog/adreno_pakala.h    | 2161 +++++++++++++++
>  drivers/gpu/drm/msm/registers/adreno/a6xx.xml |    4 +
>  16 files changed, 15718 insertions(+), 322 deletions(-)
>  create mode 100644 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
>  create mode 100644 drivers/gpu/drm/msm/adreno/adreno_gen8_snapshot.h
>  create mode 100644 drivers/gpu/drm/msm/adreno/adreno_snapshot.h
>  create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_glymur.h
>  create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_hawi.h
>  create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_kaanapali.h
>  create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_maili.h
>  create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_milos.h
>  create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_pakala.h
> 

