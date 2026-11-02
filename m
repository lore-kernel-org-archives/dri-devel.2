Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703AB606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pXmnZnFm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JoeVo9sF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C22210E627;
	Mon,  2 Nov 2026 11:33:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1238410E627
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:33:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29A1Sp3402501
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 11:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6eApJcFtpZRdgO9B0TQZd5jM4n5PQ6ew8DlGPQpAuDI=; b=pXmnZnFmxKHeP8NA
 YIKHDSfNZ4enHJuh5RwRYZwP2wQVggeE+7Q23FOkLyY0n0bm/kdwH0iNLQWAfnwc
 F4TeN748CBkjapSluA13Ay+rlQbI59FPWrRJaDhyAlE+vIIy1TEcRorVAWA23ID/
 vCytx2Kem1PkdzI+lPb7JXR9t9vrHVpfrRK2iUOHSC5wKT6XBhz+pmvXYkp82kl9
 3UGLqASuOJrf5ByDpaVjQfhphse832EAe/R7ljnVapJxInTtpLQCzkLHedmrHQ3R
 FvwuAKZlLkkzfKHRjRKeDecR53LEz5O8CYmvfhQDrr393nWgXHIfPQBP13zd5Pkl
 8grj9g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfe8vmd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:33:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-943fffbc5dbso43324785a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 03:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793619212; x=1794224012;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6eApJcFtpZRdgO9B0TQZd5jM4n5PQ6ew8DlGPQpAuDI=;
 b=JoeVo9sFyCp2W7mmwRmz0TQeD+ccB9aHEFcxFzr82Ohv9yEv0khF4L5tKd7IygepnH
 j52fMXskUgOYwJ9Telw1ux29aaTaMRKaH1ij0U02/LtphmatbF7imPG4O+h/DWDZzt9D
 bU8nzXEnVU1obxZ4HeMFgxV8qB6o2oV+rC8P/2Gsq898UMPoQ6nuWW453MV50qOWDAXw
 m6HsdBy0qtoNN8uug67p2S6AXHcKQUxHkyGE3wycfZ0fNCPG/iN6OLbl90bnJ4LfDmdZ
 S2OcZPY34cDhlCwxskgJvRqcgmF8HZcsTcdwP1IYrkP1+WbZnGfTruWk7BCc7lTTBJkt
 HJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793619212; x=1794224012;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6eApJcFtpZRdgO9B0TQZd5jM4n5PQ6ew8DlGPQpAuDI=;
 b=lgiROzDxe57u3oDmgKvf3BdMtPcNVZHEDb/1aaLkhV8nLFuhDQ/k8U0dGskk1vWJLB
 oKvQ5E/0uZr0be6USsOFpRTtEk4EN9chnpsxokAfTXNKBoPPVzUkJR9PvcrpsaZDOFCL
 pebLzXQdr3IOOLxFkEimWmRuZVrANuqu6Y/2f+K1ZMqyrHTxlGUYpHhflMZIS3kT4KZH
 tawbFhiK4Gzy18yZaRYwGY3dX1CrAt1IrDIs3CGFLOweyInKF7JydqGMj11DePVV8+bY
 aysdEcWWV3o+afNZlcIjKuhFGIS8tiQClUIQaE1ziuKf8P8tHLuQay7NRqYeBDW7f31h
 7Hdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVfR8pM5KqCfcNHQjg+k+cwuvAB0F9dRjTiXqcHfsILyVHMoe+M6Bi64D1QuhRaSAqQJ12Q8B5wCo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJuarBGozczMfdi3MKKdGJrWpeMGoLV5nhwYGL932FDcT7e3c/3
 LuyklyWijv0yaF2jn1v/6rdIfstVNPPu9ZMvhhr9Uu5fuB8eN1yLCPB9BcVNUPmLaxHOrAjF5XP
 YayJ0MAIqn6rPTj7SkPs5ItLcpAW4RZmKexiiijTxh4ADcWP4bVcYtAGgrGbXdBNQXTBaAoA=
X-Gm-Gg: AYBFou3Nld3rEVxV/VMqrh1/XIOSa8EOVsuIi990svkIkebls53Uv0T8fTukv1e5E/D
 VVHuxhLT+bIs5wXUIV5Y1UfTefTHfJ1H740g0hyejB2nlQNy2UbMGu01m/tq4G9lQhhclASYKHP
 gG1r5/96+lecvFPjj2gj6LOFLX8zpQNl3UpsawiI78lNEqndxYvh+i64FO/DelW9oiMHc6pnaar
 956Dm+77xwoLaQy3Gj4QFl5eNPUPjaFB1YvWYFoSgC0FvzyV8gXGNlUD9+XFQUUUG2Mz8AOmaea
 CffYho91z1bid3BDgpDQ5pfHInNwP2X+6z3u6gEIisMTGRWgIzkhWiUolosV4pjfPr176+naVN2
 WHk4CGfYXYbKp50cx6GeuFGEGBhVCDeS6/R5V9C48e23OLweVTY8hi87g0aE1ecO+O+crpPI=
X-Received: by 2002:a05:620a:a0db:10b0:93e:508b:7800 with SMTP id
 af79cd13be357-9442140aa25mr1504793485a.0.1793619211451; 
 Mon, 02 Nov 2026 03:33:31 -0800 (PST)
X-Received: by 2002:a05:620a:a0db:10b0:93e:508b:7800 with SMTP id
 af79cd13be357-9442140aa25mr1504791385a.0.1793619211088; 
 Mon, 02 Nov 2026 03:33:31 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe4aa12sm373481666b.52.2026.11.02.03.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 03:33:29 -0800 (PST)
Message-ID: <fc2ef1c1-4132-4060-8a50-3fc5ac4c301e@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:33:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] drm/msm/adreno/a6xx: Mark cxpd device_link as
 stateless
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
 <20261030-gmu-sync-state-fix-v2-2-89d3082d97af@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-gmu-sync-state-fix-v2-2-89d3082d97af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae8750c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1r_rKV1dNJARR5MeNUoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NSBTYWx0ZWRfXylINkhON63G6
 U/B8BToGa9KX+//CyJO5VIHqJixidTaKDj8veCfnYx3dHXU69c52B+hLPt2rVe9NHbB/VUw0uDQ
 uWcUl1p5VtsFEUcO/SLAZ3qIZkS/MQxuLljws2kiFSPJEWMjSv1nk0asEd0jhvW7ldXxLkWj/Yr
 2C2twSGJk5V+GjXYNMLIF6yx2b5wceNbQf3TW0Jcd6agKHbYGv3bsBC0ElGN1ZYABBBBMwRjoUw
 BNmfoUcvrPqCnTw2iMqc3vcMjnBa4zdwAAjhBzrPODNInqB9kTX8bThYcteQoSlC+3vVuObptJB
 sUEzHy9nf3Vw609eY1i6fLd8a/E3Cduy92Bg61kTldtFHQUQAFUhOC3wMXvmcfpptwFf/jF3+BT
 r94IRUSwS0bfZwwQlNe9RJcYB4VENJVQoQth2a/r6rVS0u39X2qOYgcwCryyTR+ZrP/6Bty5FoW
 CyBAeu6FvnIK0lMM/PA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NSBTYWx0ZWRfX9Hb+4k3NtZZz
 t6u8XxTXEg0VbEI5h3lyuh2NaD8GhlLbMf3wGWNYEQVcoCoaPKQhINkoUWxYjVue7UlPK93aiY1
 HinvxQn2RvjrY+gBfRLCh8dVcIEHbPk=
X-Proofpoint-ORIG-GUID: uSOnvAEUuyGkW8zBqIwgxg1VJUPE3-HQ
X-Proofpoint-GUID: uSOnvAEUuyGkW8zBqIwgxg1VJUPE3-HQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020045
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

On 10/30/26 6:09 PM, Akhil P Oommen wrote:
> Since the cxpd virtual device is a driverless device, it has no real
> struct device_driver bound to it the way a normal platform device does. So,
> the managed lifecycle doesn't map cleanly onto it. Since the lifecycle of
> this device_link is managed by the msm driver, pass DL_FLAG_STATELESS
> together with the existing DL_FLAG_PM_RUNTIME flag.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
