Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52AACD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A8B10EF41;
	Wed, 20 May 2026 16:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GdR1oXdM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C8T7yIMu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9761E10EF41
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:27:10 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KF8DRm748400
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yDLA1uFh89hUYoc7hHwlt/GqNAgX4/LhiZU83C8g2Wg=; b=GdR1oXdMGPiV/UyL
 GmRgMOjQyNdBFz98dduco6c3ld9VmhYxkarRT5XKZzJBXClsklr1Jc9bipbMHYQJ
 1hg4r/TkKvCKcumPRS+F8P034HDgXtCAr29x5188qAkjmUarQdRb2mgF6cK8fjRp
 VjLJ5q1jQA+/NMV/LgjZchOg9W5iNThMNTHR/XqWhkoe2wA6rqdZyWC1cQT2Ym2O
 GrgeQ1VwB1zro+46xv1NiyhQcknwiRrwZZYBuNHms1032nqKX9dKJrNI1ZcadK04
 VWBvWAFHJvmt+KvIE5zXRGrhrwRY5aborInFFJmgFtBMbJnBmP9tU8nSxSOxe3Ou
 Pl8SkQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6gayp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:27:09 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3041ab826ddso1376619eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294429; x=1779899229;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yDLA1uFh89hUYoc7hHwlt/GqNAgX4/LhiZU83C8g2Wg=;
 b=C8T7yIMudI5x7nESs3X3DE2lGblRJBFuUJJnWZS/HSoVFo+ZKNDVOicklStkKtZhdV
 e6zf23jLSC6ufZ/BRqzMPDzcr8qkAetSF1aQ3vsRARMo6tDwmJi4cq84H2zUajxFhQte
 GYDcZAn6xFn46w1RGU6MooWKcadpM4mah+rXOzWnV2lPvDFQSqO/aoK5jJvb7tnz9I/3
 6358QX7nO5Cf8jjN8E6EX2rL/wIBntcDSuA/yDNJxVbPCKD8ElbwThXzXCVSzi91UJKI
 i9RqnfesPIPlcOGzk7P9Jl/WVFU4e7uo9B/wm4zAShgkEmXQ4QEmFJy6aaLxQo7hR9aj
 O/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294429; x=1779899229;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDLA1uFh89hUYoc7hHwlt/GqNAgX4/LhiZU83C8g2Wg=;
 b=UWTkqX0h6jvS7z8i0lyNM+7nBfOhStAjypnlQfwjzkT3UodLeoFVRfNphkdfbQh6hF
 YcEVbP0kv2XngCmSHiw+DtGJ7mFb5A0zO2bTmwAMLxJVjelV4DhuAYzH8pA0GX//W7Xx
 573E4IejR3rkxsP+wfhjZvAFJkArduqj4G50uNyQudxHqyBCbWNwzbzyHbgN0X1LsXUB
 GWsYzLJn+aiDox1zHAM0pnhB30IF7y67MB/z/dfWmLhEiIp49IrKfogMnMfny+nSknqF
 XgWqKoinx0tZr0TndXLxsGDtUms6r+OWfm7tnb961+0/bGVHV4AuIKW3iYlTgKozLU61
 +DGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jok73roWbou7AIiVRzrKqXrFz+WLfJh81bY/B+mcy96RfXk0mUWCJakZ3gpKNEtkM3lNomu/sdmU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEJPaqtdf4KzDpdS8mhxL95SylCYYSKTHGe1DVZmEd/sl3HB6M
 j1zE6fbVpx1zjbuL7msExI+youiHMLX9ru1Xy96msZnCzGUmNvNOcVtiSxg5m8BcaVN9XZxsxqX
 s5OOFopYhDwP4/wDkjk1id+E/Rz8QgFJse7feyIci0Hq8mEO+mtp5npXUpNtfedkKEK9tJ0A=
X-Gm-Gg: Acq92OFjj/sx73JFaUAeT15m8jRGQ86qoEGnRH3TrXcRXNqNneX1GVOSl5O8+bbTOcB
 5dM6qG5+3EE8eHZBgNQ3wNjTEwru3RoAWczFw+5wp5iFZpziZC8W+KAM2wuxJrGJyvdaR7I1G2Z
 GBIswLtO+fcMDqgDEf/qBxPjc62RFoGR8ZKCButrFfqd4P3oyRIv+aGatwudIE3mcEBwd8yg8AK
 MFANBQRAedcfg9La5IjkWWn/ddrYELtHQyK631BckKYxf6cyQKN5uDRxcGUBYAhsChIO34foqf1
 YMYULI0I5ejfAa49DcTco5+yVGfHuU2tuQTeavLBMxG05cOhG3jNPjVuAySzAeC52LW30T0NYu1
 c8EUrp2BCVnQp7fhV/MWIhByjDkSY8xNXkGaj2P62G3lomeIPlYGqcLoG03h/EV7eopjKCtKjG5
 tiWC1FJA==
X-Received: by 2002:a05:7301:fa0b:b0:2cf:3de7:22ad with SMTP id
 5a478bee46e88-303986a6856mr10450856eec.27.1779294429110; 
 Wed, 20 May 2026 09:27:09 -0700 (PDT)
X-Received: by 2002:a05:7301:fa0b:b0:2cf:3de7:22ad with SMTP id
 5a478bee46e88-303986a6856mr10450814eec.27.1779294428468; 
 Wed, 20 May 2026 09:27:08 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e3c0sm24600310eec.3.2026.05.20.09.27.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 09:27:07 -0700 (PDT)
Message-ID: <bc3eb187-d0a4-40ce-b72c-1724b33e28ea@oss.qualcomm.com>
Date: Wed, 20 May 2026 09:27:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/16] firmware: qcom: Add OP-TEE PAS service support
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-remoteproc@vger.kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
 pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
 srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260518072856.22790-1-sumit.garg@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518072856.22790-1-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0de0de cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rrczaL3BcTaDGf8zvC4A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: ag7jfcN0EWxO3b9hyOueT5V9pwy4e-Dx
X-Proofpoint-GUID: ag7jfcN0EWxO3b9hyOueT5V9pwy4e-Dx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE2MCBTYWx0ZWRfXzq9Ln5dfkjn+
 ycY8rbO8KtfSQeMZTjG1n23PBvfDqyRlanu6vb50tYQksu6YhWrGIOnL//4UNKzyV3XhOvcTgjo
 v62dUsHOE08JW9tfiyq6tmNgyUYKxwsiO4lzYnWde2TEPi0Luqf1m9bH2wPd8Z4aLmuXt6t6YjJ
 drAWKQ53SdweRphBHL3Wmui0lXoEI2UxCo0KESSg5rthCQhbGVtkCHrI+RJjsAYNFRQkBMfj/hG
 X1p6tZxxgXjHtLXxLq5rvZiQyvidMb1tQHrWOPea12GVje+qGxp4fvLF2Hp4h/rd9M1vHo7mZni
 5mLfTQcAE1J+6BlZ6zWL3Vnz6CaM3luT2t0SwayV50dCm89DUmwz9I4IYhZWcuQCumYE7H3tJfr
 ktT9JmFAqB2NZ9kHd5T28ss1r5qT2iBfuMi2ED5FAUOBJEnkeJc4WHlXiH99AvgtjzB8Uebf/Ln
 BVhapEZrqg413UdNWng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200160
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

On 5/18/2026 12:28 AM, Sumit Garg wrote:
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
> - Patch #5-#14: migrates all client drivers to generic PAS service.
> - Patch #15: drops legacy PAS SCM exported APIs.
> 
> The patch-set is based on v7.1-rc4 tag and can be found in git tree here
> [2].
> 
> Merge strategy:
> 
> It is expected due to APIs dependency, the entire patch-set to go via
> the Qcom tree. All other subsystem maintainers, it will be great if I
> can get acks for the corresponding subsystem patches.
> 
> [1] https://github.com/OP-TEE/optee_os/pull/7721 (already merged)
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sumit.garg/linux.git/log/?h=qcom-pas-v6
> 
> ---
> Changes in v6:
> - Rebased to v7.1-rc4 tag.
> - Patch #14: fixed ret error print.
> - Add Kconfig descriptions for PAS symbols such that they are visible
>   in menuconfig to update.
> 
> Changes in v5:
> - Incorporated misc. comments from Mukesh.
> - Split up patch #11 into 2 to add an independent commit for passing
>   proper PAS ID to set_remote_state API.
> - Picked up tags.
> 
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
> Sumit Garg (15):
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
>   media: qcom: Pass proper PAS ID to set_remote_state API
>   net: ipa: Switch to generic PAS TZ APIs
>   wifi: ath12k: Switch to generic PAS TZ APIs
>   firmware: qcom_scm: Remove SCM PAS wrappers
>   MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
> 
>  MAINTAINERS                                   |   9 +
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  arch/arm64/boot/dts/qcom/kodiak-el2.dtso      |  35 ++
>  drivers/firmware/qcom/Kconfig                 |  21 +-
>  drivers/firmware/qcom/Makefile                |   2 +
>  drivers/firmware/qcom/qcom_pas.c              | 291 +++++++++++
>  drivers/firmware/qcom/qcom_pas.h              |  50 ++
>  drivers/firmware/qcom/qcom_pas_tee.c          | 476 ++++++++++++++++++
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
>  drivers/net/wireless/ath/ath12k/ahb.c         |  10 +-
>  drivers/remoteproc/Kconfig                    |   4 +-
>  drivers/remoteproc/qcom_q6v5_mss.c            |   5 +-
>  drivers/remoteproc/qcom_q6v5_pas.c            |  51 +-
>  drivers/remoteproc/qcom_wcnss.c               |  12 +-
>  drivers/soc/qcom/mdt_loader.c                 |  12 +-
>  include/linux/firmware/qcom/qcom_pas.h        |  43 ++
>  include/linux/firmware/qcom/qcom_scm.h        |  29 --
>  include/linux/soc/qcom/mdt_loader.h           |   6 +-
>  28 files changed, 1119 insertions(+), 320 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> 

In my automation I do bisection builds and it fails when I bisect.

At "remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs":

../drivers/remoteproc/qcom_q6v5_pas.c: In function 'qcom_pas_load':
../drivers/remoteproc/qcom_q6v5_pas.c:244:44: error: passing argument 1 of 'qcom_mdt_pas_load' from incompatible pointer type [-Wincompatible-pointer-types]
  244 |                 ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware,
      |                                         ~~~^~~~~~~~~~~~~
      |                                            |
      |                                            struct qcom_pas_context *
In file included from ../drivers/remoteproc/qcom_q6v5_pas.c:27:
../include/linux/soc/qcom/mdt_loader.h:23:52: note: expected 'struct qcom_scm_pas_context *' but argument is of type 'struct qcom_pas_context *'
   23 | int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
      |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
../drivers/remoteproc/qcom_q6v5_pas.c: In function 'qcom_pas_start':
../drivers/remoteproc/qcom_q6v5_pas.c:322:36: error: passing argument 1 of 'qcom_mdt_pas_load' from incompatible pointer type [-Wincompatible-pointer-types]
  322 |         ret = qcom_mdt_pas_load(pas->pas_ctx, pas->firmware, rproc->firmware,
      |                                 ~~~^~~~~~~~~
      |                                    |
      |                                    struct qcom_pas_context *
../include/linux/soc/qcom/mdt_loader.h:23:52: note: expected 'struct qcom_scm_pas_context *' but argument is of type 'struct qcom_pas_context *'
   23 | int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
      |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
make[5]: *** [../scripts/Makefile.build:289: drivers/remoteproc/qcom_q6v5_pas.o] Error 1


At "remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs":

../drivers/remoteproc/qcom_q6v5_pas.c: In function 'qcom_pas_load':
../drivers/remoteproc/qcom_q6v5_pas.c:244:44: error: passing argument 1 of 'qcom_mdt_pas_load' from incompatible pointer type [-Wincompatible-pointer-types]
  244 |                 ret = qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware,
      |                                         ~~~^~~~~~~~~~~~~
      |                                            |
      |                                            struct qcom_pas_context *
In file included from ../drivers/remoteproc/qcom_q6v5_pas.c:27:
../include/linux/soc/qcom/mdt_loader.h:23:52: note: expected 'struct qcom_scm_pas_context *' but argument is of type 'struct qcom_pas_context *'
   23 | int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
      |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
../drivers/remoteproc/qcom_q6v5_pas.c: In function 'qcom_pas_start':
../drivers/remoteproc/qcom_q6v5_pas.c:322:36: error: passing argument 1 of 'qcom_mdt_pas_load' from incompatible pointer type [-Wincompatible-pointer-types]
  322 |         ret = qcom_mdt_pas_load(pas->pas_ctx, pas->firmware, rproc->firmware,
      |                                 ~~~^~~~~~~~~
      |                                    |
      |                                    struct qcom_pas_context *
../include/linux/soc/qcom/mdt_loader.h:23:52: note: expected 'struct qcom_scm_pas_context *' but argument is of type 'struct qcom_pas_context *'
   23 | int qcom_mdt_pas_load(struct qcom_scm_pas_context *ctx, const struct firmware *fw,
      |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
make[5]: *** [../scripts/Makefile.build:289: drivers/remoteproc/qcom_q6v5_pas.o] Error 1


This is because the 5/16 patch depends upon changes in the 7/16 patch.

/jeff
