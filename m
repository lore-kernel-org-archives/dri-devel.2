Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EC5FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 06:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146E710E103;
	Wed, 29 Apr 2026 06:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g438JSka";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j3siFXct";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EBEB10E0DD
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:59:45 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T6F2uC1282820
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rpnLGvqaOGowhqbh0BhtKXXR
 xHvBmmvOGqR1wADwXo8=; b=g438JSkanjOpVQqT4BPx3R6bpd1VJbbmWFD6dKOd
 jFfFB+w7o2BFIQkM8DUi3dk+eLi2MmG2yFu2mvJoaVjZRpuKpKC8SOHGN1T4k6HZ
 eH9ZrtpUlQslZMlhYlYVUFi72Xrodhf1bXWVnE64mFiuiPhsLVRgk76DPLSLdQOe
 3wpSPbqj+929j7SchNlWiT/Mvmx2f3w9te7+sxffPyvR3SZ4QpMR9dvdKxnbHoHd
 r/5cgF5H5psWIcz6rpRnrZ7KiVHDlYy0AVG7IKRCWWDzx4ABdZYlug/nS7Nc/tDD
 /Al6A+BepM0Qxu+178Yh7cY8Ecg/Vm71wutdCwmhxrioxQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj8058y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:59:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b465bf993cso124974835ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777445983; x=1778050783;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rpnLGvqaOGowhqbh0BhtKXXRxHvBmmvOGqR1wADwXo8=;
 b=j3siFXctpZ2S9nad6Y6tvTKQAR4nQCjZp2+smEHLx9h5kggsxaf2nsNeiEBjL4l916
 LHGIVxSIzt99b56YX7Nl+3HrIwfxdY5mLAt+VdF3EiCnBJEWAIyLn2LpFv8zILO9budF
 9v6yqyQyUDhzofeBOgHawvogn5TLgxCYnkbjx0RffDzn5cYmqX9rc48nW5VgETTnwL7g
 yFOSNbR6xicKwcOyM1YgtcLLBfbrFTU1+RXgqi5AoaQOOhu/HEDpZCPPMtjp2/G/3I1M
 uATvXwzhUEvALCcqWnGeqsoK1nbD7smOXQk3013J+pT2aElgxitF5ghnYaqolplidhvv
 IbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777445983; x=1778050783;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpnLGvqaOGowhqbh0BhtKXXRxHvBmmvOGqR1wADwXo8=;
 b=RjOMtjJJCa1AkhXEQU7dWe2SvARcFORdc/C7AM+QFKA5n43rydnsHgIDcETW8HzNaU
 ZPgJCLtyrWFKhovNKFn0cieDMIgMEJozAFMXvRyEbV4i9TRIMt/oVEjzZZk6G1L/DtC+
 rpCrVkOwmXY4MSFLvqBY76ZZh3IddfVeGlE9G8bp2tbUq7pJWoxg/9crbIq0imDSp1/c
 Yj5x2R8dag27U6noIhPpGeEmIhuqfSLzOedr0dkep+ZN0WRDX3pqsL1uVTNZacyczsOp
 87pyRmUvIf091FjvmQo4mCD2xgXtPW5JMuKdt+462ZR/ybnSAdOc/XDAlAMyXtC6S3Z9
 Qk1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eh4tQNlT1ZoCUdmNV8SJUFSlsEa84KLNQ7i35M82hFjl2t68Q0cMYxkcrAkSy4BSFV9gQdXC4glg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjkF8pJntu4Qaqxy2uJij5SKtmhf4OpFPk51mOatoaUEEsGCbf
 clXXRDD70PEmL0Q7B0l5GWK9Yoao9yPHBh15LeKVHWi1xf4cmQutj4fZmAx5IcFSw0kqg/hXYyp
 WosCZZZ626Fx6fvebmW03Q+8SBZYFC+DXDHjTGgD4jYFGuJzZzBW1WB/fyFHLZ7TOseieUv0=
X-Gm-Gg: AeBDieuz/VbjabYVG3dqFJog5nW5LC9T2sC20hUScN5YVumV+y7KZyY3Q3ffigaulq/
 ZyrVyfJX5jL1f6Zt5VNNF7Naeq/eMNXqhnAMyP6esiWpbWatu7kj9BcmUci5GdIgSVlRu9kGHVp
 LSSKa6TltWl0d8kUMjueY8QQhA/BXsHoeQDT3v8aVQt/cXU5z/DUYq0HKXQG6YCnR/dU4bpXsGm
 mY5ro+2SKeIGOFXCbjURapI+Kc3mFVtUR4atEzzlUvRVbonHoFW3j+m5qHj70GgsQriqJdcb5LX
 jvptXbwLv0GWDq4ddtcrfQssGm7LGLJTzFW5s18aVxNvad+AnAiJEHoRfNlCcNz6eLjnfBtD7Wd
 YkW1DpZY/w6FlStlPGs0DAe7kMmu4Er3cqOLfAhSdNhIOsiNGP6UE4BaFSI4=
X-Received: by 2002:a17:903:984:b0:2b2:ec31:25b0 with SMTP id
 d9443c01a7336-2b98741da0dmr24709075ad.29.1777445983169; 
 Tue, 28 Apr 2026 23:59:43 -0700 (PDT)
X-Received: by 2002:a17:903:984:b0:2b2:ec31:25b0 with SMTP id
 d9443c01a7336-2b98741da0dmr24708625ad.29.1777445982436; 
 Tue, 28 Apr 2026 23:59:42 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988971938sm11669805ad.71.2026.04.28.23.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 23:59:42 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:29:26 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v4 00/15] firmware: qcom: Add OP-TEE PAS service support
Message-ID: <20260429065926.5iliebd3d2j6bong@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-1-sumit.garg@kernel.org>
X-Proofpoint-ORIG-GUID: l9b4OKVSU3EqtGepzTx_Eath_KaryBDj
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f1ac60 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IpgJVh4PXWExouJfQAQA:9
 a=CjuIK1q_8ugA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: l9b4OKVSU3EqtGepzTx_Eath_KaryBDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NyBTYWx0ZWRfX9+RcrcmG0rwG
 xsok5epR2aTCbK1kP2Fg4lPcMA8V4bJuMYVaKdDV5TQahOCDKpj3iqxt8L998NcxIi+CssCVVW7
 +Py4HFUKtDE/774qAHGs6yXNwI1KSAJcP4tHuq+fur+KDmxhGW9Ga4ADTZjsz8A811PMzLFZg/c
 5aydnLCyxZjwRp5FfeDbStePq8nvOamyC8IqsS0KS8T3xpf55T404Dg7aPKfgL1BWXU6OgA3Ylz
 8YJLIBQH9qpfCaWjcm8TWUyOBcqoWP8LM5fE0Ad7wGdvxnfXVBZ1glbYSv0HPOVgwCJOvkk5F48
 xEKxk3GUeMgJ53XzPo3PrasIz/8ywdCiQhdApxu5rEDIPcKtrl+BwIGRz3ikyy5Fa6fzc9Q2Ind
 Ud0MniDrYGoOfzc1Aim4maK5KYgWXhodYBLJgJ5g+60BlEIy60TAcVYF4e9fJooLU3dE5z/i1hj
 HuScKb8ix0JQTC5vC+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290067
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

On Mon, Apr 27, 2026 at 03:25:48PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
> 
> Currently OP-TEE support is being added to provide the backend PAS
> service implementation which can be found as part of this PR [1].
> This implementation has been tested on Kodiak/RB3Gen2 board with lemans
> EVK board being the next target. In addition to that WIN/IPQ targets
> planning to use OP-TEE will use this service too. Surely the backwards
> compatibility is maintained and tested for SCM backend.
> 
> Note that kernel PAS service support while running in EL2 is at parity
> among OP-TEE vs QTEE. Especially the media (venus/iris) support depends
> on proper IOMMU support being worked out on the PAS client end.
> 
> Patch summary:
> - Patch #1: adds Kodiak EL2 overlay since boot stack with TF-A/OP-TEE
>   only allow UEFI and Linux to boot in EL2.
> - Patch #2: adds generic PAS service.
> - Patch #3: migrates SCM backend to generic PAS service.
> - Patch #4: adds TEE/OP-TEE backend for generic PAS service.
> - Patch #5-#13: migrates all client drivers to generic PAS service.
> - Patch #14: drops legacy PAS SCM exported APIs.


Gave it a try to test the series on Lemans with Gunyah as well as KVM
hypervisor and all the remote processor are coming up successfully.

Feel free to carry 

Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans

for the Series.


> The patch-set is based on v7.1-rc1 tag and can be found in git tree here
> [2].
> 
> Merge strategy:
> 
> It is expected due to APIs dependency, the entire patch-set to go via
> the Qcom tree. All other subsystem maintainers, it will be great if I
> can get acks for the corresponding subsystem patches.
> 
> [1] https://github.com/OP-TEE/optee_os/pull/7721
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sumit.garg/linux.git/log/?h=qcom-pas-v4
> 
> ---
> Changes in v4:
> - Incorporate misc. comments on patch #4.
> - Picked up an ack for patch #10.
> - Clarify in cover letter about state of media support.
> 
> Changes in v3:
> - Incorporated some style and misc. comments for patch #2, #3 and #4.
> - Add QCOM_PAS Kconfig dependency for various subsystems.
> - Switch from pseudo TA to proper TA invoke commands.
> 
> Changes in v2:
> - Fixed kernel doc warnings.
> - Polish commit message and comments for patch #2.
> - Pass proper PAS ID in set_remote_state API for media firmware drivers.
> - Added Maintainer entry and dropped MODULE_AUTHOR.
> 
> Mukesh Ojha (1):
>   arm64: dts: qcom: kodiak: Add EL2 overlay
> 
> Sumit Garg (14):
>   firmware: qcom: Add a generic PAS service
>   firmware: qcom_scm: Migrate to generic PAS service
>   firmware: qcom: Add a PAS TEE service
>   remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
>   remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
>   soc: qcom: mdtloader: Switch to generic PAS TZ APIs
>   remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
>   remoteproc: qcom: Select QCOM_PAS generic service
>   drm/msm: Switch to generic PAS TZ APIs
>   media: qcom: Switch to generic PAS TZ APIs
>   net: ipa: Switch to generic PAS TZ APIs
>   wifi: ath12k: Switch to generic PAS TZ APIs
>   firmware: qcom_scm: Remove SCM PAS wrappers
>   MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
> 
>  MAINTAINERS                                   |   9 +
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  arch/arm64/boot/dts/qcom/kodiak-el2.dtso      |  35 ++
>  drivers/firmware/qcom/Kconfig                 |  19 +
>  drivers/firmware/qcom/Makefile                |   2 +
>  drivers/firmware/qcom/qcom_pas.c              | 288 +++++++++++
>  drivers/firmware/qcom/qcom_pas.h              |  50 ++
>  drivers/firmware/qcom/qcom_pas_tee.c          | 479 ++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.c              | 302 ++++-------
>  drivers/gpu/drm/msm/Kconfig                   |   1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   4 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  11 +-
>  drivers/media/platform/qcom/iris/Kconfig      |  25 +-
>  .../media/platform/qcom/iris/iris_firmware.c  |   9 +-
>  drivers/media/platform/qcom/venus/Kconfig     |   1 +
>  drivers/media/platform/qcom/venus/firmware.c  |  11 +-
>  drivers/net/ipa/Kconfig                       |   2 +-
>  drivers/net/ipa/ipa_main.c                    |  13 +-
>  drivers/net/wireless/ath/ath12k/Kconfig       |   2 +-
>  drivers/net/wireless/ath/ath12k/ahb.c         |   8 +-
>  drivers/remoteproc/Kconfig                    |   1 +
>  drivers/remoteproc/qcom_q6v5_mss.c            |   5 +-
>  drivers/remoteproc/qcom_q6v5_pas.c            |  51 +-
>  drivers/remoteproc/qcom_wcnss.c               |  12 +-
>  drivers/soc/qcom/mdt_loader.c                 |  12 +-
>  include/linux/firmware/qcom/qcom_pas.h        |  43 ++
>  include/linux/firmware/qcom/qcom_scm.h        |  29 --
>  include/linux/soc/qcom/mdt_loader.h           |   6 +-
>  28 files changed, 1115 insertions(+), 317 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> 
> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha
