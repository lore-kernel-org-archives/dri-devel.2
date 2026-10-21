Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C78606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gR8dQDXv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fV8YTEs5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB5110E35F;
	Wed, 21 Oct 2026 17:44:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F1C10E353
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:42:33 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFTofe141134
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KN+PgTF350Bf5Q08x7ilqI8W
 /r74ND/C/koqFQV5cX4=; b=gR8dQDXvW6Egwe+DwHNnTIKewLTe2ebFyOreWuTt
 rCDnG26YKc65toONtrrne0r+HBq2kkeEabnxnxFE0XK6HN4HioijCvS3iK74SIhl
 YysrV+4UcoY0GeGUvWcLHU8rJiWj7ON9asLO1T67AJ2wLEcX8v+jj0mqZWRfT/UD
 NFNc9Cev2ZIdWZGb2xd6s/AYam2ZODJdKG1x6sjGCIOQkXIdJMwnCjSY3a64CIYJ
 sembuh7p7snPwPKouv4Lq2zLCEA+Bs99/NgTtFPqOGV2OJ7s/u55H9GuieKallEm
 BpO1rTlSqXkdvSDEVBLXAPRSzrIeky2INjhy+6d0755fPQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex589823-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:42:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934956beec8so220105485a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792604552; x=1793209352;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KN+PgTF350Bf5Q08x7ilqI8W/r74ND/C/koqFQV5cX4=;
 b=fV8YTEs5wMJ7RhE3KAQBGkjbqw1FbyJ7pcth/HGogvF25zXlv9wwWJyi/mO6fYH2Be
 BQKRq4aTKAgMsRpm7kfZLJGoulH/jBZE2UbsXpZx6hO/NSZBY7/BtAA6DREKYX9rnJmD
 9xWhaHCXwd8Pc/Y6XOki/xEU5bYRfJ5wSPynWYFmcxfDd3Nvy3b6YUnqw/A2S9q2GB05
 0ZipZarVIHGK1dGJoaA5t7ybB3UnOI/UwZ7fp/V8kzmSGnhCb563WRaQFwFKy3uWdn8T
 2HQRamhRM1ViqRW+tz8x1u+HsUS3KqxkcuJMW9auF3UwZh0pGKt9iMmuz+ywvQFW+h3l
 61FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792604552; x=1793209352;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KN+PgTF350Bf5Q08x7ilqI8W/r74ND/C/koqFQV5cX4=;
 b=BVW+nrbs9fBpdjADx8YggsHDjRvPA6e/RaHcFeKskK8IUmhwsctGVjQAOi73Nv4cyQ
 gigrdFvDXcpC6IA7VdjijAfxgMmPSnAcqvnsj6VG3bX1FhElcFujV8is+iSfS6js7rJg
 sOdfYgJHBrjcXT92wJB96nsG3lYp6a6LJrXBG+F5RvA2Brd2VpLYVHiKa0W2QWW3bcAn
 jRR6jaTH6EhUA7ijucW5JebNrV7mu+NbFOVsjWxzohG5Co9gkDN/pXpxgDFJTRynikhV
 r+XyweO6UPkrEfR7G5hZJG53wdgNJwmkvQ+OXbOugaWOxr1riO10u8XAehoGQf/CnkKk
 obZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrpYceJ+b/TG9IwqPdSxlMZ97kWT8QEwEzOk/MVAx9nbD/JaC7E9l+q/J7x1tNVGK82GIA9cEg9TQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKElOzEjeZ610DcXls38X7G7fE2dxGAuqpETS4B1ClzbU1Np5PJ
 aBjH8HcigUb77rt4S7/qcpMEWALJIh+MP4iJ6obQkYNWjkP9AqNwzSxGPikJrhIHtQpooGP3MuV
 91CP6X34LwF66KBV1I6f3Mj6kWJV3Vsx9ZiypASRjt8ufA48BZSKIKDnpmJ9zuxViVE7Xt4M=
X-Gm-Gg: AYBFou12x8SZdOpahcSJ6bU5blp37J+4xc6OITAnXf2hXGNYA0cZE0HdEd0NznMuP55
 bKYcYJpnDnDw7NOBg9XL0q6xhq1I27R5OK+g6N2UleNYe9tER0xcSJmXPdoh5LAgUIaDKrfJHr6
 WEjZ142+95QR+iGwHpN6VBEFL8g8Q+/QnbbAumKl82p2/8KgrV+qw+H9ayvFomWFTge3rVN8jFS
 NgGDv8dL01kaKK7UEimLars4qIU7ZMiTDKSC6xUibnI8pX4wtWogGxEaTLnUCPKYSSgrbcHIEIN
 qn8Op7nDLRTBCJlT+KbiyWbul5VEEipe53rdD51QwBca4SexW4jBrdUT/jCwJynGaPuklLkyWge
 snV6/IZhj0EjtU/2i3/LRkeKDieDwW7bUz5rXxGMyjJDRcDwDcyE1b2YBLtyiCbbgAjpWGIEwCz
 1iSL3oOkG6U9oH
X-Received: by 2002:a05:620a:4493:b0:93e:d364:c9fc with SMTP id
 af79cd13be357-93f57e5e30emr518394885a.5.1792604552207; 
 Wed, 21 Oct 2026 10:42:32 -0700 (PDT)
X-Received: by 2002:a05:620a:4493:b0:93e:d364:c9fc with SMTP id
 af79cd13be357-93f57e5e30emr518389585a.5.1792604551742; 
 Wed, 21 Oct 2026 10:42:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfa4962a59sm231037e87.4.2026.10.21.10.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 10:42:28 -0700 (PDT)
Date: Wed, 21 Oct 2026 20:42:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fabricio Akio <fabricioakio@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Paul Sajna <sajattack@postmarketos.org>
Subject: Re: [PATCH v2 2/3] drm/msm/a5xx: Hold a CPU latency request while
 the GPU is powered
Message-ID: <54itft4rw53zcxoyx5vhxz3zfenxgooorp6lo44vbsdayrq4yi@3f4btdyicop6>
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
 <20261019-a5xx-gpu-pm-v2-2-457aafbb28da@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-a5xx-gpu-pm-v2-2-457aafbb28da@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX8DDtJvXV0/Hb
 q6wAvtwQd9Z4KDTVh4K2Kp16euZuUvE+JG6VUK4fyAr50QkkuOUHd19rk4Lab9J+/jDUyQE79lL
 r13dImGetJxn0UThOSuyDAVnNhfa6PY=
X-Proofpoint-GUID: aNBAQBjUFiM1eCcWBnnxUstBoy8vV8Pl
X-Proofpoint-ORIG-GUID: aNBAQBjUFiM1eCcWBnnxUstBoy8vV8Pl
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad8f989 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=j5_2AGnEbwvZtjme2gsA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfXyEY232t8hINy
 7/feZYi8GOL+3am0RB8Kj8aWuSGSYhjsjqSdIUZo5i7DJNuCHo4dQgV3dUZVM/kS0p42vvmovuq
 SFxR/LGYMiZ8FTcDr31RG/Egs8r83pjsdQEOL9VwXYbtgTZtpzWnhTdRHazCrFmFjlStTL5/+5V
 HzW6xXdN5VIgqFh6cLl1KTzlwFJvardG5yJUznpBKCF52ombBPEsaO9PausjT0gagh4hd06Yqr1
 cOC6m6RY1Tc60QzsnMKKHw/SdYprwUN9AeLHN425RERrbsQ4Swyy9bMlhTBLlwq+QDJriTNm60N
 6WdPR323jAoVmdljMyOadOrjCUJC8OZCJAkcavNJ1qLsVeGxSD6qGklNTgoAMbPFTa1XkO1AHC+
 qS9sHNuTmo0iwJykO4CgvlZxlYZWgq0QSiYLPrbZJEcMPXi8oNdKNXBRuHMmUUkHPTASSnloVeu
 IWH456U9y/XCRHHmJ9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210070
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 11:05:09PM -0300, Fabricio Akio wrote:
> On SDM630 the GPU was observed to stop executing while the SoC is in
> system-level power collapse, and to continue once the SoC wakes. Its
> interrupts have no wakeup route through the MPM, so it cannot wake the
> SoC itself. A submission overlapping such a state would stall until a
> CPU wakes, and a stall longer than the hang detector's threshold makes
> the driver recover the GPU, which can lose a frame.

Do you have any extra patches that you are running with? I don't think
that currently Linux can hit system power collapse with the GPU still
running.

On SDM630 the GPU is running from the CX, but we don't vote on it (yet).
With the CPUs awake we keep a vote on CX. With the cores going to the
deep sleep, the CX might drop below the required leven, causing GPU to
die.

> Qualcomm's downstream driver holds a CPU latency request while the GPU
> is active, qcom,pm-qos-active-latency, which keeps the CPU idle
> governors out of cluster and system-level power collapse. Do the same:

Could you please check what actually stops in your setup (CX corner, the
BIMC vote, XO)? I think the proper fix is for the GPU to vote its real
rail, scaled per OPP, in both RPM sets, rather than keeping the CPUs out
of their idle states. I'll have it as a part of the CPR series, but it
needs a bit more of the cleanup and polishing.

> take the request when the GPU resumes and drop it when it suspends, so
> those states remain available once the GPU has gone idle, and on
> destroy, which unbind reaches even when suspending the GPU failed. The
> limit is a per-GPU catalog value, downstream's for each SoC: 424 us
> for the A508 in SDM630, and 518 us for the A509 in SDM636 and the A512
> in SDM660.
> 
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>

-- 
With best wishes
Dmitry
