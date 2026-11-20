Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6E606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eXqeABCi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XaausF7C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A7EE10E35A;
	Fri, 20 Nov 2026 09:50:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C82110E35A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:50:03 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7fLRA3576543
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=btKSo5BXidED8vJ9NCAxgb4J
 b5p91Creg660EJQWOVw=; b=eXqeABCiXtEP7b0ixlF+/asBaZcSBH25X1IqeNRK
 +KRqErrPys5/vR35Prm5xuHkmjwnMaqJDBdBAXEcYU1wE80QxWeOiYrgCKbJcpqF
 /ubyek/e8gRQ1w9VfE/+4XvTVk9I8EZDYoucRHoq9Kek/GvVLRM4mhLhi2wplRWC
 NuyvBGWwrAYuktAsGcfNivFf4WuWT3+rhZDSRRht9eXkcBw167p42LaxMxipVsJA
 I7OLKKHpii7G/n6PB7BAN75rU54WLod6VO82uYcetJRVzNkoxRnYnOSgnVz2Md06
 uJi41zOsnSChj54FPyxU+rKFM32J9SrSWjP0f2o+iPErNA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu80trr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:50:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94967c6d4f4so82370685a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795168201; x=1795773001;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=btKSo5BXidED8vJ9NCAxgb4Jb5p91Creg660EJQWOVw=;
 b=XaausF7Ckug3gXTdt3PaX97AiZ4VhXKlqciuRyIpvLQjlr3B7SCOdYHuCysejWMyvo
 jGk0X6ge3HulF3zf98YWzQXlQpggCuv32rsvqEWpKQmsOWz//F/JaPKEtymLJ51XjVdx
 BOEymRxxU78eEfk1GgJ5HXiGCU+anPe3B8LIsmjzNlv0ZoK9qgISGM4k+UK+fomo9JYI
 aO8X20REh9mmtGGly4PvxWRAWvZdAHtf/vmqW4GyusO2SEgIuaNyfZ00SyFtemWe3hfq
 NEmK+RejKWP5/iuH6QXkOUgjgQIo3e4epMsx0Kltjjxdlt17p/q/MnEEH+UWI+lapf8f
 O6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795168201; x=1795773001;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=btKSo5BXidED8vJ9NCAxgb4Jb5p91Creg660EJQWOVw=;
 b=y16myOtg08LF9DuoauMpVvyfkrmQ4RGxBVqrXUIeQK6ucXBsc2y4NHi4Foh0rejPpi
 1Bo5ttr0yvhqv5eHNLXCUQrMm6MEAYA98VCHFFH4+zQPx771r/aY4eYqJC6SJP1aFQI9
 ZVrZ+CKRt+ZfQQ0gNMPyfz10a0QygxDrteSb9SCXlKVZA8Prb4AMrmjBiUrtH44mmojm
 peaeBS5DvT+VNQKi1rk7DOVoaMA58KqxHP9VnUWIPENIBbpYLyzWSyLzA7QFJod6OOkF
 ZRujfuyp8UQ1CUS5ObF9vyRxePgBBP/A0ljxGfZExTEIrdzXmH96AdOcPa3npWvvE1hM
 cvqA==
X-Forwarded-Encrypted: i=1;
 AL+hErEEsyPJX2+TPO33xHPkU/vUOoz92n6FhfZT7OHUPAT9lJm73zC9cgnP7VGhBoqVxV1Y6TKmUKc+tzY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/EEzivawVwv2gRIniRsfI9k6bIjbzuO4vh550ef55RXSoYkE/u
 Evr5tWxIjJQ3d4v14felaiHrVLqqFuHgWv23zkyAHo8wMxVKIVKPVsEst+IAqu4CC2ZrO1ZRE1m
 G1sjYRKSnjz18/Q+da0HqV7vdH9LdGXUTYTWlL1AceRAvBWCsKABpSgMv9sUNhp5WBYo7E2I=
X-Gm-Gg: AYBFou0vF7J7vV3j7DcA99eQsryEANxLt54opSINOxvZq1S3+pvIDjV3YMVeJvb+m+9
 pHVEDs4OKDfT4i+xUjZsRUkPX2Oc6FvWE0SxBFH37oljxWabGUdU0dobg6XwtceTO9vs2V5pnKb
 dptEHHORPaz67gO3F12iQCzG8zpTipLIUgprtnxN077vQ7dQs+x2EuVNqe7meHYSRZanvgsfpCG
 yn9P0pNnpsb12O0KWA6heqGj+jP+6hsQ1OROf75v3LmsTFfwYHSULNxPClYNCfcB0DgFTcJQXj5
 vjSW8lgT9fcq7O2MzF5RMh5wQ6hZw3VHyKY64S0BUIHrqa6UTensWUnQEOK60Do5qFY5ZmlNsqF
 vXdBYolzTOICdMfQe7VQnLhK9jBH5Be0CvN7TLAWzFihmwM6IMsh8vWSNCI5wWHAc
X-Received: by 2002:a05:620a:31aa:b0:949:3066:5551 with SMTP id
 af79cd13be357-949bac80948mr413719585a.79.1795168200879; 
 Fri, 20 Nov 2026 01:50:00 -0800 (PST)
X-Received: by 2002:a05:620a:31aa:b0:949:3066:5551 with SMTP id
 af79cd13be357-949bac80948mr413715385a.79.1795168200326; 
 Fri, 20 Nov 2026 01:50:00 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61b8sm4189249f8f.19.2026.11.20.01.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 01:49:59 -0800 (PST)
Date: Fri, 20 Nov 2026 11:49:57 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: qcom: shikra: Describe the GPU CX SMMU
 aperture
Message-ID: <nny5rvdlbd7dxbc57cemmebswdzbubs57h5fhwxftvcskajpor@shl26vygzqb3>
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
 <20261118-adreno-scm-fallback-v1-6-e99cdbf3121d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-adreno-scm-fallback-v1-6-e99cdbf3121d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOCBTYWx0ZWRfX3VHGSzVLHRaC
 gp5dwKz1niXA2qSDq2wF52gJ4FPgWOisuPI4/uluXmeczhCA52C0LvtI8MlFTg2PnOrUlKulLAH
 ZqI3Kf0qgyvWO5uasSagr57HYPeB2a2w8fvl1rFKKcOk1jb9e6B1gx3OmfbTHYqYMkXFxUoc5ua
 upbrtk5euWtLp0V/UYQH1jLQ70dWBrdntWxSR6wg3HT02myiNyB9bhF3aQ47BX7qYJvhnfTbG37
 7TSwGylQCUTW26+ekvxxAoMGbS+vaiFJmri5Rp/WKBnRurIC/53u1EfMx+ZRLjP18+CZErvjr4U
 AI4Yk9DZ4vYUYNsGcbvi2O40R1TLDYkHMB0rV6tfFReF9/Zo7GGw9D5VqRrpWhvdOPIYOyUA05l
 qywO/xPfh9wKr0VbgrQqpxev5Za1M/4OctAbLu2atpl59hK8xwa52V+QxTfpgzTRSuYBe7MhyLW
 fv94vFQHP4wuWg3O0WA==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b0017ca cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=gzqzoBdNbbgndB324-sA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: VZPSyI5fGRf5mbpWulXrhwhG62bXVQXw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOCBTYWx0ZWRfX/AzM3PRtXEAL
 ePynYQmQ7xrU6HAjC1Ow/jgcA9xDjsNvVo3vVWNrNIJjXL8L8ifCKj7FTwIpq8NoVSCVYUTowCT
 nwEByps6thdRUxQbbtCfMTW6JYCRnxs=
X-Proofpoint-GUID: VZPSyI5fGRf5mbpWulXrhwhG62bXVQXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200038
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

On 26-11-18 18:38:30, Puranam V G Tejaswi wrote:
> Add the CX SMMU aperture register region to the GPU node.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
