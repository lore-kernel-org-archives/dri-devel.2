Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0CCCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D764F10EEE5;
	Mon,  8 Jun 2026 08:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YbgAiNTD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h5bCbfxt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264A010EEE4
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:16:47 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586Oscn2317899
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 08:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8AMCbCTPRI9tqD3oyXlXIADZYYKHqYbtOIHsuIoklMc=; b=YbgAiNTDvhc9jdct
 PmanbLRJZ4shvZoofRsmmTqcuOlAtVfcDOdfRraSIB/eSu29Nul8Yuen06VR9WfN
 g/lE53tyIh8YGafG/lNHRshpVZBAf50+u+85sx5dLt8PNhuvRaybkMfdCw5V7781
 fnTLX5GXRJ7w2iEYpzdlqeVXGz3ZmPruURBHW3bo6rmfiVP05drjCDsRgO14nwNI
 NLPUZlGly3p+tAwQZ7PLzaC1EIWDaf1MI+y8/aadgc0f3piAl2iDWIA6fqWOMp/r
 +oFHFwfxBd0IDd0dZZkca3mrz09QxuYssSdY2tnpCtRqfagJvEj3e4QVSVpveiv3
 /bPdjA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcadxga1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 08:16:46 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915ccc2d4d2so33115285a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780906606; x=1781511406;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8AMCbCTPRI9tqD3oyXlXIADZYYKHqYbtOIHsuIoklMc=;
 b=h5bCbfxtG4/Ua9/iD2Jek1TaN0fn4bjJ7XfCIOmTQLvY3By3sm/ewgoo/5ofNKtt4z
 Q3lxiMQ+eh3idMnJg2CHGBJzZFZSiZMyjFV49hGVnNMoNpIlSiv1F7wo9nyqICsZHVCR
 J90ZHT82GSh+/VYLqPqZnl/HDfhn5tkscZcH97cyJ64oJ89wB73TcOm4u3uytcklbxay
 CiZnPbcMLWgh3yDzmdE53AY1j0K5K6McU9tL8WKbOIv+JxidcuQq0/jGdagEfXT+onok
 Bo6qJcEXhQGDM2w+InrYOUomHqO5AshCGMDWCVTZm9HNHpkmRVfQmDhyfzHbQJMgK9WL
 4s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780906606; x=1781511406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8AMCbCTPRI9tqD3oyXlXIADZYYKHqYbtOIHsuIoklMc=;
 b=PxdaRgl1vOr5r8Xr0X7kTQu9OY7CZ8VZyfoHYcMpEMPjcy0/LeuNaZpU1G+zCUL02Q
 y91IZc0O2QI+caKa4bY9+FK0IkrC19Yfw1Bf7G85W/+Xma4x3gqhuVNmEBFPl4FXRPjO
 zDVIXBMcPrXZSFUso1V3RyRFXHsmZXO9/k2Ax5NR8Um/9mnY1UsPiQmzFJvbTgpA03bn
 wS6jfxQVDiDCmi1JMUulQ+LKXc25MsvbEUyEubW58w81GRI9GPRA3//X6jsVsbSifeot
 M4m8d+hWWxyionUfPncv3+WZOUunf8HOydXAwhpdF54Ny+oE9kqK8hN/L5KLbIk2omEX
 jGFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UFXmFvK0oTPJTqb3ZJX5WMHm42c2V6boB2f+lrSGXRaQvl+sN7zr4vewbFMAf2ksWLIQBGJDXiLk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzmapmj2PWuKPEEYhwDg1Lw2sNEe4lBtYpqxkHPFWjJjGexZVmu
 fUGYigz4atvrHepKs+++sEIoq8yiKLjvBIISzgy1DK8mc71f7xWcNEo6h8LfaseS2vBjO2O+bOI
 Wh6liNDv8iRwsTzy28Y0PLQRqw8HX+A2M6+2O3Jpr+tafSn5T6DwqA4L1uK5ioK82T/S4PnI=
X-Gm-Gg: Acq92OFR9MuujPuHvM1QyRCfooS3G5R12DM6unBEjMwHeX1yi6+bURKyOj6UNaIOAA8
 VVtBYMjqK5dYrc6CXk1hWnfh5MBcUkv5jyksoSU5rANq3puXCuhtpmlHHSvX3bOAH2HtLxQlXfj
 VhuTPq7zTynvin+VMY+KQaU+tL2zz+nKcEiPtLKZyx5IrlMkREiy2HAkhkiSdx12EFZIi9yE9Sh
 6aVtmxMmu0CJadZ+vaa8UWQm53chS+ssHE1dQnzdSXWaEnCy757yI3Ph6J0grukDK4mvOvZvUvh
 nURH8fCClgxy/9hEMSrVvhPnnqVtA3nep2TkBGmDMcWLIzFXF4QGZ5om+EHJ7biC3R187WN2TTb
 IpW/1yT672i9w6VncEd2nx0zrvyUd7VufNCwhgjCjY0ifJ2Z21MT7iZhI
X-Received: by 2002:a05:620a:178f:b0:8d7:ed38:8189 with SMTP id
 af79cd13be357-915a9a36533mr1322506485a.0.1780906605667; 
 Mon, 08 Jun 2026 01:16:45 -0700 (PDT)
X-Received: by 2002:a05:620a:178f:b0:8d7:ed38:8189 with SMTP id
 af79cd13be357-915a9a36533mr1322504485a.0.1780906605125; 
 Mon, 08 Jun 2026 01:16:45 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05208e897sm817822766b.25.2026.06.08.01.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 01:16:44 -0700 (PDT)
Message-ID: <943d792a-6980-4883-9644-904c6b4832d6@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:16:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/msm: Fix task_struct reference leak in
 recover_worker
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
 <20260605-assorted-fixes-june-v1-6-2caa04f7287c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260605-assorted-fixes-june-v1-6-2caa04f7287c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DIa/JSNb c=1 sm=1 tr=0 ts=6a267a6e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iwmd1eEXldmoXfJYBtMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 1NJOnQ50jb26mNG0LCFI5a7ILwnJg5DU
X-Proofpoint-ORIG-GUID: 1NJOnQ50jb26mNG0LCFI5a7ILwnJg5DU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfX/RMDtA8MVLUT
 4I7KUbX1cCtKDL99Q41o46sIH9r15gbmExzNtzSPB+km7Ysryl81V/+LQSDV00t+xb2rJnV2GV0
 SWVdJlZBR0Y4GE5avdCJG/SDq1n67C9rs4iODdXEqxqSBEHxAnBdWDUO4LJhoNCCqLQN6iuSHe0
 TbkUjIwuUCxb01TrhNkPJO2kaI2t+fl7MgvROIczenxEUHwFu5rJV6NE+gBCOk2jXJul8Nd36xs
 /X88DrPF97OXM9pkmWMXJEgLBgQ6wnbSrAunVzWr2YTKlNrRGNbBpIdt3BDjqMuxQjoXA0tTvN2
 7Ev9GqfRgzgRE96tv0bbrYXiuRO9jNIW8M6yWxpv3QyrbCmYL7PZWwSlzc1p/1PsqD7P1e16FH9
 X2jN02RLHhdThBwy/uhgkn6tbqcpkoFq8NQynyhaFK9mkLuJneeEYbk3c4Qp5+2vKOKy7B3CdWF
 ByMZAK+oTdaWb48650Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080074
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

On 6/4/26 10:08 PM, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> get_pid_task() increments the task reference count, but the
> corresponding put_task_struct() was missing in the else branch,
> leaking a reference on every GPU hang recovery.
> 
> Fixes: 25654a1756a4 ("drm/msm: Update global fault counter when faulty process has already ended")
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
