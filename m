Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85708606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 05:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WFKeXP7h;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cH+ZedCL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CBC10F8D3;
	Wed, 21 Oct 2026 05:49:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A64B210F8D3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:49:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5jA0J3711648
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eZlxAyBevgnOZgMWqXb33BV1biF+L6ci4PbJk2Ledrw=; b=WFKeXP7hTU7Qcmnx
 vSn8aoIPInIUlpFHSb6EP5or3x5IU8slSvFDU76IPfKvtA9t+VYSMTaPmc0kg123
 ruD23M9fCx01FhJ7RErYE+ij5FRr/z3GmoXZONnmGO1KfR5F+wop00b2PsyAHvSV
 4zkVK+DawGwjCJECk5+k5RjvQsdGrVO85IfhA2y0cgV0wr3GFEeGLDhBuy1eK5wY
 nx6na3l0gjNrEUgcF4JGihLMBFQSF2F5G4FO1bPcavA7JJqO8hok+p9M4fUuWb9J
 ERn9LSxq3EdKBbbXLaAg50sV4BZB3bFcVgcVMiUUFaO3xeSGHsZlmKRpupCjyXNs
 ksEiTg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v27bf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:49:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a06da65d92so280920b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792561751; x=1793166551;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eZlxAyBevgnOZgMWqXb33BV1biF+L6ci4PbJk2Ledrw=;
 b=cH+ZedCLygVr45o/4CBx9yjVTAN3gc+ELjC0HuFu6lSG5u9VZL1GZZjSNwJdqakgGX
 T+62lUmbBO1WlolgL8nCa9RDWQSRs8gdWdqWTSI0fulELWSVEUri6MimD7gulv4t8+yY
 bjo45ECRaqL2um6A2Qc4jOyyUEZ8fLD9lR+JcmO5pX5CysX4S1HXW9lN45q/dr3yMZKK
 sTzkHWHdprz/MCZukOzqn9hTJQcum32BKXcnd7I8btjn5750HKHskzn+M5C8tQFoNDZT
 ni3sTbyJrQ1Q7hD90QVoMVF+T3p+oK34btQjQHZo+/iQ/4oF5Q53SoW0ikyWzZIvWe3k
 CndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792561751; x=1793166551;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eZlxAyBevgnOZgMWqXb33BV1biF+L6ci4PbJk2Ledrw=;
 b=BfjHgWE3DAKLRg4dH7JHHgMRLLeaXj/elQsHB6X1KMo3B/VT/OWZ7Fk+SsBPXBOcO8
 K7eoRnxpAs7bDUCwomMK7WacwF1xm7eIfUXxQHwK3lXMXN0SxGfLF7lh7kKDRWx+Jm0c
 SRJIPQm5RGMCWCJXP+QTacUEY/oSYS/NbMsr36xJMXD6RvlKa/kgEetflH8JuRh4MMpp
 H+L8NzA8NHNCGdQM+I4eJTESd2PN53Pz1q4WnfTGtPVZLfAIxyB4YxHkbbrn71sx22Se
 Td0NXdDtWkDoEG3ZWm5LCqggVUQz0Fo6UoHebQ/6XmDGkt3oX6kg0g2VRc9Md2kAzr5K
 wvZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3PDBhV8VL4bT6SrFivoVWoM4XLqKDHqRfEbU1KNkSOfD5mHXoZRl+5DlUOd2CA+40oqO4umxBlbE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK2EyWqgZVgWJutxbWtJ3QmFzVTA626stEqZmFr5AMnr3ZpLPus
 uv4Cf6nHuq6fSZ7xDN0MLqAAUgVSTSdBDiNqfTmlp4AjCR89yOqkVw30gXn4XIcaWdnZZmZIJ64
 lLwTOgxcVEoH4Vazgz7tOqX9Rh2XS9ohEFMQ6MeDl1CIULPplkPUJIKWgq7Y2VNFeZFn9EVo=
X-Gm-Gg: AYBFou1Hj0wjgvm+7lyAaSVTlk0xshOfH+NpdhZ2A/nKi9pWxuxTxPZrDWZh51r1rG7
 rGen+rLLvhBwGkVhnP+9nDqnOQ2BbP2sdVOjOGYafiRSVCtw8c8Acta4Kj41N3ZTpKLL4ASkmjL
 R2qSO4j7oiurRzGFl4UbN+LZbeCvV5tRO/fh5VlD7KRcDOP9z8jo2CWyIu7eS+KSpn/EVwRLRIE
 QPdgC5DLN+rHxbN6bEISlCaE1VxzF3sep5i9DutsVIaLJhTSeEzdZr0CgjnDoxbNkeZiQw5HHIR
 I5d+VeMO13h8qEb/q1Y2WgsRE/hMA6PeBZk2zaND69sLgH953v95+U2/tsbpNlfD5g8ll3LGrvy
 6e0yXUsIVqrCtrF8Ef6hXjdfJ
X-Received: by 2002:a05:6a00:4287:b0:89d:a947:9d58 with SMTP id
 d2e1a72fcca58-8a089e3fa8dmr773628b3a.25.1792561751031; 
 Tue, 20 Oct 2026 22:49:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:4287:b0:89d:a947:9d58 with SMTP id
 d2e1a72fcca58-8a089e3fa8dmr773611b3a.25.1792561750583; 
 Tue, 20 Oct 2026 22:49:10 -0700 (PDT)
Received: from [192.168.1.13] ([106.222.228.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a0894b49c6sm415288b3a.17.2026.10.20.22.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 22:49:09 -0700 (PDT)
Message-ID: <e4e2b8d6-46e7-4f59-994e-39f3d09d334d@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 11:19:01 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/msm/a8xx: Enable CLX feature on Adreno X2-85
To: Oleg Keri <okerixx@gmail.com>, Rob Clark <rob.clark@oss.qualcomm.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Bjorn Andersson <andersson@kernel.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <CACSVV00x091i7BKW+bj0RUnkd4rOrHXbhZ4zF6SuTU1NAqsFTA@mail.gmail.com>
 <179248663855.32151.9955864156939592299@gmail.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <179248663855.32151.9955864156939592299@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyMiBTYWx0ZWRfX8ME402JHBz2p
 NaiMclzjGR6qeheWcEjycoiztVCHug+RWQKobYoexin3AbQuu4AtJxDFI6FpjXFnOlT5cAZZWul
 C5F/NHoSdt6GL44GlU8Wx43GXZT2Ruw=
X-Proofpoint-ORIG-GUID: kD1-s01phMiFgSTLugUFyygFU-7ADimQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyMiBTYWx0ZWRfX3zq4wf8c8DIG
 vUvTYLSJmVii7dvcFbhMyuN9KXqn7ww3RgQ0FYMdmuX3+ffgJhhE6KjvtIF9NxQ6WBaYjKOVM5e
 FJZDm058odRnfwe1nDSfCCCPZT0tXpC22qcbzN0uBFaCK+jDjnE/z01hmL8llILNMM3lFJbr6dV
 gDLGnCcVaNulMKFOAWJl9Sl9OY1LPGdK+42NiUHfF+NMAczZ/abWumHBAw5Cj93rBR6FrarFx6x
 dIyUTlMTgSIEio+Gk9X2Bg03UKLij47rnQYSfEoKMMcxfewa0QJbFvs2FlFey2r/MbTRzeTE9Rl
 DXjtyGWwdxAORxymply63TuCyEf73hdWgQNn8jYTMFSjq+U2UF4r7w7s9+Jn1TrnBa3Ret0AcOB
 0FdoY+3N4GRXj3MTRiWgK6BCCahggef8We4Mh3fmdTJwTaR74rKuwwSjdt1+sazMSA0rBjY6nKf
 ucRuV9hH2RPQk4Sf7Zw==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad85258 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ipsIN8yD8anPosRfiFfp5w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=cjh-xzagbiWEAgRDvXgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: kD1-s01phMiFgSTLugUFyygFU-7ADimQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210022
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/2026 2:27 PM, Oleg Keri wrote:
> I guess this should be investigated further. Yoga Slim 7x Gen 11, no modules,
> firmware built in, so the GMU comes up at 0.6 s.
> 
> It's rpmhpd. Before its sync_state, rpmhpd_aggregate_corner() pushes every
> vote to the highest corner. The gxclkctl probe does a runtime resume/suspend
> of its GFX and GMXC domains at 0.18 s (qcom_cc_probe -> pm_runtime -> genpd
> -> rpmhpd_power_on), and from that point both rails are stuck at max until
> rpmhpd syncs, which is at 2.8 s here. The GMU then does its CLX DCVS
> calibration on a rail that won't move.
> 
> The GMU log buffer (fw v5.2.38) agrees: the calibration trace of the bad
> boot matches the first good one step for step up to the ninth level. There
> it stops, and the firmware puts HFI_F2H_MSG_ERROR 0x007306c7
> "ResMgrCalibrateDcvsLvl" on the debug queue. The GX_BW_PERF_VOTE timeout is
> simply the next message we send.
> 
> With gfx and gmxc taken out of the clamp (hack below) the first GPU init at
> 0.6 s just works, CLX tables included. Three boots so far.
> 
> The wedged GMU after a failed attempt is a different story. Retries after
> rpmhpd's sync_state still die with "GMU firmware initialization timed out"
> until gpucc's sync_state (fw_devlink timeout, 13 s) collapses CX. That's
> what the gpu_cc_cx_gdsc/NO_STAY_ON thing in my earlier mail was about: the
> recovery, not the cause.
> 
> The RSC side is not it. On A8xx the GMU firmware loads the RSC sequencer
> code and TCS slots on its own; preloading them before the first boot made
> no difference.
> 
> Abel's CRD failing even with msm loaded at 90 s doesn't match this, unless
> something keeps gfx.lvl high on the CRD after sync_state. Could be a second
> problem.
> 
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -1009,7 +1009,7 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
> -	if (pd->state_synced) {
> +	if (pd->state_synced || pd == &gfx || pd == &gmxc) {
>  		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
>  	} else {
>  		/* Clamp to highest corner if sync_state hasn't happened */
> 

Acked-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Could you please send this out as a fix for v7.4? I will respin the gmu driver series and revert this
bit there. But that would be v7.5 stuff.

-Akhil.

> Oleg

