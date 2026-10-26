Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0B606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WUgYFR4s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cw35qeaG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB8310ED0C;
	Mon, 26 Oct 2026 09:15:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0895010ECE0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:15:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4b7P41907871
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c2xXoHXxXOmiBow795UfR0gDHVbeNq9gSE/Bwil+gxQ=; b=WUgYFR4sTGtWjFKY
 66jXQhx0WuLCHICfw5AYC6k356oboZqmTcAx8JputT4MnDGKLVG6kxeogx5gJaFx
 QEFnthrgms2Bq1Tapxc7NEU9pQcxs0EBOyj9PD4D87KKLPvBfOdZr/EpPNx3bnyz
 /TNHhQvZj0F12A6F+7WcAizuC6DrUpIrJmrx0eV0t2PEVHfFiEDlQxpxDk39kwN2
 xlj0D02XC+eZzkOgyH23hJU1E4M4/Rfv0TDaDXTxy7qYaa6tTO1iD6J0BhkkJtOd
 tFfBxkeVD5oI6aDlsK7j6YJkSV2lo7/xBulgzCyJ7IhEoz2uPnGYLXRyQSIw1ub3
 zj6gOg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm0gnqfk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:15:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb1091fffso19991185a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793006138; x=1793610938;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c2xXoHXxXOmiBow795UfR0gDHVbeNq9gSE/Bwil+gxQ=;
 b=Cw35qeaGzbbnFzNYC7+Og14gJztIgrd4FaJXiatEWqSqBGxGANYcCfvPFmeCN6nSLL
 f5kElnoGJKAWC1kRB8X72Xc/59pp+9l0yb8fjvbSA9I0ra48UDwz7zwocrpDJGWfLEoK
 vMsuAVFEOIEhxluTIb39tPf6SOfmuJvx9Mrcd4S6MaD2g/glBcPKDdT2Bh9qOkI1B1SX
 L/tBocz97MLQkyVIVf+1EaUj8n0M+15ZChMmeaIFEth5owrSaQPnG2t8/9RuJPg5XXC/
 DOFLMz9+qU04eEES0EG8KGu7/hKWUAIHtzY9j39MJxWNnLAWk0U7k5iycVUXeEbp4i01
 EeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006138; x=1793610938;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c2xXoHXxXOmiBow795UfR0gDHVbeNq9gSE/Bwil+gxQ=;
 b=Flz96SI2C1OPSAhfQZ7WOyXixO/mW9+cGntCkTDUfcuFCnCXtucDvCFZab9IaNhofv
 SLW6pTBj7Bf1cOnbKbHFBSC32Ic7Z3P0aQToaMo+ywGWMTa1o71YsJrELIasrlN/vthB
 8wFCENG+gGqzLBjiSIog3AkcMLNwaF9F82EO1BZtTUP6Jc9PJKMXFzRtFrPKke/kZUDv
 hHeQ8KizSYu29AYAFFfX9yrwiw8ngeuVesXeEBRqk4d0dmg/sNNC2EU+URvTd91M/TxH
 PJzRTPhToGTvlJ0vFevPJQOPpCZbHBxpbfx5X5cyvVusYp7uC3tKWfMKYeIOiGXLfKAi
 iX3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDP4vxlvB95M+v/eXlh9ovkjCQk/7ksEXJC9g2mBbRw47Q8h5cx619GV500ZDEvG3Qb0fDe4VKUIE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLFUxFhdsR11vZhmP/rYBdiNodDP+Rj9Xv5fWfrRxUbyvzlnKIO
 3TTfQc01aGsNKZpeaZhcv6p2vfIJ47FlwsuGPQxXRBthk3UoyHKe5yriybOj3zKFKGO6NoHo0ZM
 lDUR87H1zK/wnihT8WyoJ9qlLHrkv/oh8LWukE8/+kNRAK9SPambvbcH+pjsj+tvtDzWUwTE=
X-Gm-Gg: AYBFou3VROJ1fPE0PbVyVwcO8Hwh0007xlCbuKK31TkQGDR35XV/5pp94SiB6T3a/fg
 5SVzMIGHgLm9GVuYYCsVwgubQ14DKkJH6pmW2bE8FP0xqNVERn7dmbvsm6eUIQVakHjtu4HWiGR
 SwZIDLLH9ttrn+Qi+G9o30FSU35Lv5oXWCoSY7c/g5LkHCQE0ccrqN07tMPcdcoLz2WQ+pFf/C9
 4CANSqydTrpnc7ThW5brU9InQdATq12MtTIOs5zudIgumxK4ZK1KzKDcApBioKdaU7biEpxFyzR
 AhsXi/DlhRM87OQJJGI0g10i2Ns7PPicuokXBHgxosXLjXunHBFoJEpSiTuL8R45CqB3FxRRr61
 7sXHqrolkJw44ym00OqqQFA==
X-Received: by 2002:a05:620a:6e9c:20b0:939:8148:1e3d with SMTP id
 af79cd13be357-940ef81147amr890466885a.2.1793006138099; 
 Mon, 26 Oct 2026 02:15:38 -0700 (PDT)
X-Received: by 2002:a05:620a:6e9c:20b0:939:8148:1e3d with SMTP id
 af79cd13be357-940ef81147amr890464085a.2.1793006137625; 
 Mon, 26 Oct 2026 02:15:37 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b44595e70asm3496891a12.9.2026.10.26.02.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:15:36 -0700 (PDT)
Message-ID: <ad790e59-9de2-4f9d-b2cf-1be9e7ebe292@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:15:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] drm/msm/dpu: clear the CDM block left by a
 previous reservation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
 <20261024-fd-kms-fix-smmu-v5-6-a5b0b284aead@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-6-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YcUad-2M2qdHhSs-3oALLNf0KACI2DW7
X-Authority-Analysis: v=2.4 cv=UfTE26SN c=1 sm=1 tr=0 ts=6adf1a3a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=h7YTzkf8KlyT4Ruvd0EA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: YcUad-2M2qdHhSs-3oALLNf0KACI2DW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfXzuFftRZOKD4Y
 vwmOqHeQvoayFXgC37oyV/WUuaLDi1dcERhBB7eKl/gv1NH4rOG4mlpZPXIKaWCLl9V10hBe3Kn
 OKWfOAeBiVRc8jEnJLGPnApMpDnq0IAi7nOtyrg6xTMXRnWId7RmA3k0i+296avpIadMr2bsHFb
 NDhqBbk14QXsWNvcVdszy4ZOpYWA2SWjHK7zo7Vyn6YWbVxz0Bftjjad9JrzgZRACq9o8yL4L16
 KLBcyQaPtRVSWv5ug4a26NtBtttcL5LjDJsDmV4ZJC0cr50Phu1N05yGxg8N4QuyT0MrJsGiVWd
 W6WS3SN99V1hUVquFGH9RTBuUBle68ZIf0dEIu4b7ShfXMoHwy+PeD1273S9q/4atKB2he1lKkD
 LMl6Bx1AfHJzLdyQ5yye2OovkX1e5etWzXkxqijeIjwNvVS2eJ/BPfMGKD0wraj4l8UKB0smlbX
 6kbLZYmMVpQTOZ6dE1Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX9lPda3EBFXaT
 DSqNOaeth/3t48+B8S3cnYyyhwErOQi2thiJB8lM9e/BSi3fwrfNHpiVgEgKESuOwFhUbEuIl3q
 xNRI2nzrIP9O69OQ0MWAvZuTG3D2raM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260036
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 1:25 AM, Dmitry Baryshkov wrote:
> dpu_encoder_virt_atomic_mode_set() only updates cur_master->hw_cdm for a
> writeback with a job or for DP, so a modeset of a writeback without a job
> keeps the CDM of the previous reservation, which the crtc may no longer
> own.  dpu_encoder_helper_phys_cleanup() later unbinds that CDM from its
> pingpong and flushes it, changing a block which may by then belong to
> another display.
> 
> Store NULL when no CDM is assigned.
> 
> Fixes: 8b45a26f2ba9 ("drm/msm/dpu: reserve cdm blocks for writeback in case of YUV output")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
