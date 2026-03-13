Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6CE105F7A6
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3031F10EC6C;
	Fri, 13 Mar 2026 14:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UYkmE4+n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ImYNfS6B";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5C810EC6B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:27:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D9TiV11498953
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=1UfQVZ3QMmjbZwV3Ni6xdPVm
 80fQVP/YkVW72bzlpf8=; b=UYkmE4+nVezerODJyFx6D+p+tk7h8vZ9Z+rSMR4A
 9XcuxT+lHciUiVhuIlo7s9gQchOOGoPFLoDcPrkMD5O9PH2sqOL+XMtjsooCJ1j5
 nmh/G8pP2uRM1AZhdLrhp7l3RK6nXgsutAiNi0GOsmO8E/t+4yeEpLNT4aNpFCd7
 L9VNqh5AhseK7+7uBqPKqhKsbBpcK0Nx14czqCcK6KuPqoQWVlcNB+dRr5BczJpK
 gSMzrglppQGVawOlvMBQQyq0N+gPukv8hssXFw9axEFKL9fkrV0nEarV0BDLCLqn
 HINcjLpTmcdFm7A9RTss3G03BJlE4My2WxP5ip0T1/+HGQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvg0hgxqy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 14:27:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd7ea0bb20so1220998985a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773412060; x=1774016860;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1UfQVZ3QMmjbZwV3Ni6xdPVm80fQVP/YkVW72bzlpf8=;
 b=ImYNfS6B5EkycTCFEzQmWW7H47mPXySBsBuv/dhGVT3WSd5aIJ8FPfyFzWmHaV0YAh
 y8d8MJDl8vwEoxREcK4SBanCFOrb9Ul8GFRhQz+nvZr+ARBMCg3/7xN3VzEM6V/g4a5D
 erioI2Pu2t0N1apoj1ivqvJ/wB7legJVYLdCu+EELrbINSTtmEVJeYdYZy2RKhcE3g9J
 m7CpEpr9RzEY8Y33htU9tka/AFMuktDTLNz+81pmuyWAODhReTjtDf3gyQeGHnfr9LgT
 gX+JPDRb+n+IrGTDRUXEC7cFJlxPxELgQhS053XYMzU05oLEYPfMFA5L0H7j6G05aAnu
 hbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773412060; x=1774016860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1UfQVZ3QMmjbZwV3Ni6xdPVm80fQVP/YkVW72bzlpf8=;
 b=enOhuWLBFrydGwBLe9Rfz/iU5d4Y5FT1RcerGEC4pcCfB6rWI93ZlAk6SSFoiL8HRQ
 zgXtl7V4O6/04ImNajfGMdK0Kj7hXb/GS5wxrGedq+Megl4A+aJ9+15Cu4hU/9u5rtuJ
 gdNHygS1C+blZWt9synoEeKQ6/Riby1GZt95YzCItkapkrcpiuNVYiDClPOyrOkb7TIC
 MHsIVjkFenxmnX2YBAZFKyxPIBZnKVlKFEDcD3SLYcfG9PMaSpq6eWtkoSr5Bd6KbDMI
 L6yNPD4fVt/dEGTA/p5M1Q2//YRDmPn2IetYpjK0dYou7jqp0XkOLHox+jQnLhBD67ew
 0/Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfwDZ0V7/oos1N2EVQ8uakzf9JnR4ah0Z1nl4HbdYjjUFXOXSJShjE36Gx9uGUg0VT2g8nbKZjCHo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZkOtpfZOvLVb+R0A0j09jiy2N1Pq3Is0whxwD/VrGlJMK/6BX
 Ck5B9Tli1uw6jpLY9V4fw1jm99MSlrjEdK9y2yXC8w9W7pJ+Obvp6c9IP2gBH105R/SMiqAnVjN
 QB5vhL+Lr8E7KuF/oaSoUDq4d/Ypovq6akV8kXlxVtX9ztlqy7YVxFDGRPH97qdkarwpVpQE=
X-Gm-Gg: ATEYQzyIJSa+vUSRDIpD9PIXGjrIW/NQK7uF3Tx4h/i6MrbMAwGJbVLSjzN9R7mQ+HR
 U8h+XGWsbREGuuARkEMMvbLC4wwWC8pW10EdUsXn2Pyop6wu1tJhOSIdU5kXLItRA4P5PWII7RC
 egjriYwDlvMZHzbvc6wt1UXdu08CmT1Gpsjm4/LKcBxE2+yb0osygwHzV4N9yb70WfU4ZBpQfMu
 tciWcMV8u+StUuwr/iKCaqf4DgOAIJYXujAbqMZYUfejZQX3PyjHB13c1vsUDn3hgDIn0U6KOFe
 ov9+mJhoKoCgXSFgnW5nb3d4VCZ/7jsdt8P8cO4T97IGvgxIGhlOSnizxwCZ5A2nyuaL/fd0HMi
 B1y+HgAcqVIqCIX7A3jTvS5qOuLGf16d1EKh5zzssB51QvUWUN9h/d0LmHe1m1Ry3nBf3j2DZ1Y
 8U5nuI+ZJ+VdaPzAjTG6BYs0pIV7g9tNZXx/M=
X-Received: by 2002:a05:620a:5350:b0:8cd:c02a:657b with SMTP id
 af79cd13be357-8cdc02a679amr91875985a.16.1773412060587; 
 Fri, 13 Mar 2026 07:27:40 -0700 (PDT)
X-Received: by 2002:a05:620a:5350:b0:8cd:c02a:657b with SMTP id
 af79cd13be357-8cdc02a679amr91872785a.16.1773412060123; 
 Fri, 13 Mar 2026 07:27:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a155f33be6sm1568740e87.7.2026.03.13.07.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:27:38 -0700 (PDT)
Date: Fri, 13 Mar 2026 16:27:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/27] drm/msm/dpu: invert the order of UBWC checks
Message-ID: <m52qs62cjqdrdidtu4l62voxjifyeb25hl33kk6rumgst3vhyl@jcdjmhq2fgdx>
References: <20260312-ubwc-rework-v3-0-b7e8f800176a@oss.qualcomm.com>
 <20260312-ubwc-rework-v3-19-b7e8f800176a@oss.qualcomm.com>
 <7ed3af47-daaf-43b6-8d2f-dc6b528d2c00@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed3af47-daaf-43b6-8d2f-dc6b528d2c00@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69b41edd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=C14lroEPiMBeiew-kZ4A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: D5DGB7J_vxN_OplXdiq2cUr9LCUpJAzY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNSBTYWx0ZWRfX8i310sOcZgHJ
 fOsQR0AkTHmesfdRrov7AUSLkjQkLURAshjBORaZKAUn/wn72rSeyfp4DmdGgD6gZDxTWaenc8T
 rXQlnkB16qLPF1U28yJHOelgNK07qvSb8d77qHhsNLAVx+/nUQ/gKVuEFaH4vOny/emzd28A8Z+
 M+UTSPNNQjEB9IzxhM4CEdr18Y7/eXUM71FgVKU1YbEe97mnlmagwRGc60s1k55rSbaq/ahD6qR
 LCdkGXmt4rK3rhQda7Vnt5uU0jDLKDyrcMsJrOhppvRzKlT29hErdA3ZEOli+OBBPARbagbnWKk
 3M6gtmsO3+giPR5p7spkpO9SXMF8eBDp24KPMm/IEzMQOwiIz51KinmDYK8vqZF8owCgBBrR2hg
 Ww1q2OOrhK2lfPby0Vrs+r0xpRYwl9luo1FXzPl4PHIdf4jebyV4ZQ8G77d7ORC0l1enFJ9mw36
 7g9coEkJklzIRrJXxag==
X-Proofpoint-GUID: D5DGB7J_vxN_OplXdiq2cUr9LCUpJAzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130115
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

On Fri, Mar 13, 2026 at 11:25:18AM +0100, Konrad Dybcio wrote:
> On 3/12/26 2:29 PM, Dmitry Baryshkov wrote:
> > Unlike other drivers, the DPU driver checks for exact UBWC version,
> > making it hard to add minor versions if necessary. Invert the order of
> > UBWC checks, letting the DPU driver handle new minors transparently.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad
> 
> >  		} else {
> >  			DRM_WARN_ONCE("Unsupported UBWC version %x\n", ctx->ubwc->ubwc_enc_version);
> 
> note this is existing behavior, but do we want to write to these
> registers on platforms without UBWC, instead of returning early?

I'd really hope that developers who port DPU to such platforms will see
the warning and fix it during the porting effort.

-- 
With best wishes
Dmitry
