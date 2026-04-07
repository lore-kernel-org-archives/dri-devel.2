Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0783CFEEF25
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE5E10E32C;
	Tue,  7 Apr 2026 11:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RH9N8BYx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K4btKJl2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9A610E32C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:25:49 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63765T2W492506
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 11:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JuA3/x1S6HYosIQcTCsqEgUi5XC8HNDAlPK2rNrD76I=; b=RH9N8BYxu/OoCdN5
 Zv7pjQeDLhWnl/+EWNBao3OErZ3jFXLuYAjY4WcpFECccorCchM2bNXs/mtxdz1s
 gK+on9zu3KOT15yfuDJ8Qn+napdG1BfhPPYoRzj0lNUIBkXZfwtMg83tf6AucTik
 YY+y2Db2Yn0zKOFj/8/y6ytdvOAes027AIFUCo+ddWSrce72uY4gnYa0v6URLo/j
 EAIxRiEp0aZS33P8OWDwEo8Ft01PeWYiy6ioI9ga8zUxQMb2LuNEVV2kAo8wDApb
 oQKvzEN3wF6zDPyh/KaAm3Sqyw7O+kA4pfO/DqoeBieyhXAixP9P49F5T5j0Emyt
 zkq44g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8te8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 11:25:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8d56ae62e86so58545385a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775561147; x=1776165947;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JuA3/x1S6HYosIQcTCsqEgUi5XC8HNDAlPK2rNrD76I=;
 b=K4btKJl23ZjUP8SiNfx7/v2Uciy1WKEJY/eQavpLijYB56VyKW5XSHD+x9SS8hlhAf
 6glmcvD8SUwkdxcBJ8OXz7tpchAMJcpwp8IdB+241iEemTSUMsV3A4j/+gwHfpEad6je
 Q6BXbyqy9GwlqXEhWVoAt3w3Nehh2f6MNG4WqQjBJciivd3TNGN92HmaLtQJA52TsksD
 LKi4jkO19H2H7XBNKL2nmT01YRKzZ52nDAjD+9ky0iZ2Oabo6IEBd+RHvxzk+YN5R2Zf
 VyFB+6+iJvC+/z38dfv7d0YQC29XZiHnHjk2FadEQCPmFJTK0VNp2bRmKQM34fZH2iOl
 cOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775561147; x=1776165947;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JuA3/x1S6HYosIQcTCsqEgUi5XC8HNDAlPK2rNrD76I=;
 b=CYoYEwepdykZ1h4XHfTUEU7cAEWjgqWl79J+uP2wq4l76nTP//17KLqs6X97Fsq7P1
 YebBHv8GDNSenAN4U+OliiLDqCPeMB0HnzDK0GakHCzMHzC/2xgqYFf/KBPDjebpfjMP
 ye+zFbHYuZ1hGiwYQ5uByXBGLunJEYaEEEhQYQRDD7uqZ+rUnkkv6qLNdveUunR01K8D
 9SKwhhYWDKXZyptdFDf1XZrEOBZ1B5w5GwL6ecbbuGPhf1YoixYeT3YBeliZsxWURWVo
 6wN/uEniSKqVCagQ4F22twto9YSKwdF3h/eHXMWv9/MwZhWW6hhWtnsahn141htxLEq6
 PGjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG79+4YvB66xGpKrIwSaEWNrFgd4cGMo7Z4f3wyyjF7wo3DOtJL7TuppbU1JVkaLOe794Ynjre0OU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7ZNlWO+uKXNcVU9yixnCvsVtttfI/z91vz/00M60TdbYw7FpY
 AyO8PVGs++022d/YpzEERIK8p1a2IGo+stxqg1hMfDHRoI2ayqb7RROUVrZBT2uuyydDFVzH8Ub
 V6bmDsjJBP1bBSNAH4ID5UbKXqLTk3ZWCR035uDxOQe7+LMKN3WhSAFzsrdSaIOuxxeShCsg=
X-Gm-Gg: AeBDievAXe5WbKewfD/XBobSD78Por2ocplMRC/cKHSW2eiLoc22IMr0sOJQe1EgbBD
 W6g1nRhElCFUNbq+o/vHg2rUbMp1jdJYbg2z38Hkfs82QQB+/mvXxnJVSDEqB+rx1GVHvfGemaV
 CAZdgBXU64mvkb8PxmlG0/DiM2je631lN7J/IgdEyGv9jUL8cm86tsyubaj9H2HcX+ZxipAoNoe
 7sihSCw4HG7bQZA2e1TveRG4R8DjCVlFaIbqcAoLbskrzkJkO6VRZ3H9mnhLooreymcKGZhNQ0h
 WESjHV+qNP5eOh8fns9Hl+sgB8gwTQNL9osq5tVfof7jBVyh9mZUgrOuitsir/1e2JPusGiIshm
 mq7ZTG8du0uDrydegoQWOMYFuUoeXCIi1mFkLQGa2HJGs0PlBhnTMtM5jskcLvgKJ4PcCr+jfUN
 NDjhg=
X-Received: by 2002:a05:620a:489b:b0:8c6:e2a7:ad1c with SMTP id
 af79cd13be357-8d41b2e38bbmr1773619985a.5.1775561147594; 
 Tue, 07 Apr 2026 04:25:47 -0700 (PDT)
X-Received: by 2002:a05:620a:489b:b0:8c6:e2a7:ad1c with SMTP id
 af79cd13be357-8d41b2e38bbmr1773615985a.5.1775561147051; 
 Tue, 07 Apr 2026 04:25:47 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66e033a74e8sm4218517a12.16.2026.04.07.04.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 04:25:46 -0700 (PDT)
Message-ID: <fc1fce6f-b37e-4d69-9121-dcf8df9740f5@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 13:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: lemans-ride: Enable mdss1
 display Port
To: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>,
 dmitry.baryshkov@oss.qualcomm.com, marijn.suijten@somainline.org,
 swboyd@chromium.org, mripard@kernel.org, abel.vesa@linaro.org,
 andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
 jessica.zhang@oss.qualcomm.com, abhinav.kumar@linux.dev,
 sean@poorly.run, airlied@gmail.com, simona@ffwll.ch,
 alex.vinarskis@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
 quic_riteshk@quicinc.com
References: <20260402095003.3758176-1-quic_mkuntuma@quicinc.com>
 <20260402095003.3758176-3-quic_mkuntuma@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260402095003.3758176-3-quic_mkuntuma@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6Cz_7N27XqxgmxSVBR0Mc1sMDQGka9h6
X-Proofpoint-ORIG-GUID: 6Cz_7N27XqxgmxSVBR0Mc1sMDQGka9h6
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d4e9bc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=XQLX8yjaJUNYVVxXu1AA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwNyBTYWx0ZWRfX3AItb8bpR83C
 1BPCyFrtPaiQaLmX0edqvAmGLH1qdgVirPRenwsDSj2eKJOmChaUj9rGQptiorppoEoC05xCeJj
 eQtOUA7jRQqxjJOeL4YyRZW7+cl4p3us+oAzUdFB5Q3tUHB3V9FR4E0FQTp1LRYe7lswFtJFOG+
 mGUtGgT0hz5ndeVFNzXoHIaCeeI61S3ytU9E70mhJbCLCt9VQAvz19dWfadK+4umsTd03to7Nb9
 RCr78c9XCOfz4+pJgxwHX+BPgLaOWhefMZWG0yhA+zHPmytRFpcSJxscEodPDrbO8QirV02LFUw
 A8mYF9r9T2WFQo8FJtliHE7toB9JIid26qeRJyKvanclMZ1q8D+riHSuRY0RAupTqYuPGff4m66
 F/83+A7n4LaVVkxQaqmC5k4DuGYc3CKPZfYntE9tNzkPQCt3JcavR0jreiyaZtw9CmckVYexBmn
 8fhWNsr5E3bRnjHuymQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070107
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

On 4/2/26 11:50 AM, Mani Chandana Ballary Kuntumalla wrote:
> This change enables DP controllers, DPTX0 and DPTX1 alongside
> their corresponding PHYs of mdss1 which corresponds to edp2
> and edp3.
> 
> Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
