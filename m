Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02408606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kNdXS4/7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BCr5DeCl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9BE112D9D;
	Fri, 27 Nov 2026 20:30:53 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4625112D9D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:30:41 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJBguO2763103
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Hphn3ZfKORUo3yr9W6IsBbo3
 W049JwCJrXs91ZHeeMA=; b=kNdXS4/7/27Bmjheg0WPfQA0MdTG89+3TYQIrMtP
 KPX1JUzQQodVcJqU8ZuOVICrLCwbfVGxY0KtiAcPltWSjhCKumY4cq0hP/d73q0k
 cAaDuMqGtkCDpD9q+2XFu3dArsBdBFA7IQPBbS8Q5N4es80BriYOYy+nF0xvpSRU
 qJct5pbmkoRU61yfmFWKyHBkw9IKirVLWipywZK7r8utenuJBSa2EG4p6jBJHIK3
 myQwJmE1hSIGngZxKB7kPMV7ZOXPSC5tRhJPSCRfWLM1oQOVwMV2iG7apDEB6TXo
 sRdUM6onL8HQN5XYj9uOEWhDjIhpFS+Nxd2P6Mqr7EzCPA==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j756kaqf0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:30:40 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67dc4e966b5so7924178d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:30:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795811440; cv=none;
 d=google.com; s=arc-20260327;
 b=DLnv9CaiTEP2yB4YUQyFZLLAPBAuJe2E4k+PGKcBNAsOkBe+BJZXeT2PAvhcNl22Dp
 1uMvRO+4kWhaSsPrsZctcQRKsSKe+JtEd/0hetWtQKjyK7RqJPt4N/R8/zZ24EXRYAe6
 i41Ks1Cyq4SNblR+9JzwFv2uuQ9La2d96hADQjDHQXCKxiY55gHW0MWJxjRa4GXNMdGy
 xBuGj4PrtYUzXZ+nEOBz2nsmDabXRt0B56R4Yfb1fxBSSOu094GD8Dy0Uy2H7y7PRwG+
 IddQ3lNUvugYlRguXEqmxS2V4kHbsaI+XnTHBi4xBnj05NodXsU1fYbbwJ6nC2dcYZuN
 bBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hphn3ZfKORUo3yr9W6IsBbo3W049JwCJrXs91ZHeeMA=;
 fh=EEfWNnFsaNUuMZ4ZkW+gRJwtxF1yymfM6CXnvrA0DsU=;
 b=Y+rhduTx+AwGmYA9asGC10e/WrNWKQsOwD966JXF2Av4l0174bzIiPj/LK/f0fYcqh
 4fnfNYuOjiWI8hYxNJO3q0PxxrV0y5BO0Rq/5+rRRxWYU+OocQ/fFyygFs5tOMSjsQvu
 /fvc16JnP1v8n+o9AW0pTJ7GT0colbcL943UjVddI5pzc6M+7aZWmZZ/JnLVWCoo6c4b
 ET0iD05OppfnycdkP1GuPu+aE/3dZyKZUQLCdQp5IMEOmwzL70LPJUpEkzHFXJs9tI6p
 D4qlQcDC20jZv9pBjh/mZSV35wzRN0OjGxZA05Ey+vHg/BamLgDV3akL20/p4Lq1umdp
 Yaxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795811440; x=1796416240;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Hphn3ZfKORUo3yr9W6IsBbo3W049JwCJrXs91ZHeeMA=;
 b=BCr5DeClxmWRlyGuJCIA70gnxyhHmvqBPFquc3Zou2fpTgXXkzdH/N+jeQMUn8tpsl
 /mNR+Qz9Lj/rO8JGiiIp4lwZvyA7AZb8St5lEmQ8aFpZQFLvmNFfo4qVAP51LWFbPtZN
 dXMz7YBymByMIrZrCoUUOZeKYWfDB3+0KWXc9k2o233UX2X7F2Peb0iFZowJD3as9+J2
 iBXpirU5TtifZ6b8xwZ9eA46XEMYTUlPZZ39HDR7gps/rrwU3kIiLo+Fz21VnLFqVIWH
 w2TzpxbjEegLSfFBBCr/6muc2fEQQ0VtdASAOVYQk9aur3/hGiqlG7uBnIskaL6+FNt2
 H12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811440; x=1796416240;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Hphn3ZfKORUo3yr9W6IsBbo3W049JwCJrXs91ZHeeMA=;
 b=bC+bDFFXRdftRK2YwUQfsGF4sOuvcymEcDs3dBmpwZ3Kqnb9VgcgSdIs2d9h0CwlYO
 IKMdYdwHfjpaDZnzW3BNfDZ0pMW/iHaP6QYsyZZ9tXXr/n7rTUh0qbnlXICjhA/C3RjE
 BTRI9BCMEznZeeRUb5+iGvU3ajYvcOu9+dj5LzPMdfusnFufiNMgfqOkM3geUBGjhDSN
 gjbGtUNRSxbhlE7S3MmDllbyf3QyHXRa5eA2dpqe41CbKoh1q9Vzb7+Ks4CgWYwDLWTY
 RMTcCd7uiTR0psjR7AaVrdr4A9jHg4y+T2KBsJGcYfOhlYey5Z/B9tn4mz28FjZTNyfC
 nJdg==
X-Forwarded-Encrypted: i=1;
 AL+hErHQBgE0G/dFW2dbqaZJEYvj+Ey3v+UVgy6DiYprviDNYgNlRgFIwi+DSeZVyLMuHd0HPPQgmlsCrZ8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Ghibp5xlXLxlEd14Qerlv3rYFYT9rmpvYU0XZ99Ys+u1izHFI
 y4d4GLuEC4eYCW4b7HNtjKMYVXTr+GiXcsdUAX5V8l6t5WRnHnPRfk93pwQcmkvWYaXlKxA9f8k
 Fe8JwB28FvoMMW+YVUiRvJ/+NjzGY7cLMSCeodQwwGZX/OpnZSA/mYaQoGl4JTNN4sSEt6JqwLw
 N1rDZEB0YXZh9ifWmlBVqMVycKcedYlGk9ghyQcjdeiObuMA==
X-Gm-Gg: AZFdTZdx+1KI2GT0sEfucPcaoQFAeZtH2eB/UxEmUeALhVoZPCbXWKJZhmSBhjvLUUl
 P0UFGvZJAs+B5F4fcDe/hSjlYdqkzZPd8PexhuiSXFRvrCKaOORAh2MKnn9ur4VUf2spf0bDVpD
 +7MrjYmoIZYiGE1qyqXIAYGi1L/u0FwrtnrHmzG2fOi75pyK9SntRS5Bm/b37rZBPrM6HMjZgjB
 zOuKIFxknznjo0YwA==
X-Received: by 2002:a05:690e:440d:b0:67b:ec5a:2075 with SMTP id
 956f58d0204a3-67df4446b92mr7114671d50.78.1795811439912; 
 Fri, 27 Nov 2026 12:30:39 -0800 (PST)
X-Received: by 2002:a05:690e:440d:b0:67b:ec5a:2075 with SMTP id
 956f58d0204a3-67df4446b92mr7114661d50.78.1795811439276; Fri, 27 Nov 2026
 12:30:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
 <CAPnEM6aAK8hwJ3EfhzS=gdMPTf+bhVgS-=JAoM+axcHzBQ1CGg@mail.gmail.com>
 <FE7B564926118C33+50565d89-ad83-441b-b85c-cafba0df5546@radxa.com>
In-Reply-To: <FE7B564926118C33+50565d89-ad83-441b-b85c-cafba0df5546@radxa.com>
From: Chris Obbard <chris.obbard@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 20:30:28 +0000
X-Gm-Features: Aa3M54rOA0nGZYSsdhumtFBM_XfbHqu3BlAs81Bv2P-Z0wUA71uwNq6De_uad1M
Message-ID: <CAPnEM6YXXVJ==OXinyZyGBfKS4iX=N+eMJRGZframsnfAeTtjA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] arm64: dts: qcom: Add support for Radxa Dragon Q8B
To: sophon@radxa.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniele Briguglio <hello@superkali.me>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX7iObzwpplA5K
 ZW0AxJ99u5yIw8KZXUp58aVq8+aWedHVrSIYn11FQ/ca8uFq3tFkoideGaAAXCpagFoZjWDeDKr
 UAyapeljlTn7DCwZ/jgPtJqiyKqqgdWvpCDaBkZrhL34DNeU68VLn5/p8XSrcl/urBpyxS/JxyQ
 cC2ACanvqK9eZGBQIm+TlfU8kiN07qpohE77BNNgXceP8+ACHjvHpLUmNM4SwW+tAQ/pjywnmB3
 f3z6huc786NwRO8OJdDE3DDFslYDBol+tlwZ9ISZYpJ7nGotcnIW1m2tgv8ikb+hH7e97YTPfs7
 TXf9MdsOPYQ66zZgbco5kHQ5kL8NakJubSI0bCA0IDIQYNIU39Vsejbi3cd4uLYIk9Do8y30GOG
 3RfDysrD9VIVJYqok8AHRLJaOptUMONJpabDPLIsSYCBLFnUtQfDGDkLg3NRJ8xQLQQfMLk2vZp
 lqM8/Mp7X3nQu0UZhRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX3xnp+BbC1Su6
 dyjtAOtBZVcCKHn8aesRKy3NJp+BrwFSJBj8yHsiULqpsmsMIGc8Pz1amXNH+YzrM+eFdH0uHjv
 JRFmFW6ytggu0DtwoVngMCvMbxvoOU4=
X-Authority-Analysis: v=2.4 cv=ebWo7LEH c=1 sm=1 tr=0 ts=6b09e870 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=ksxQWNrZAAAA:8 a=NEAV23lmAAAA:8
 a=05-C0eYiNmMOl18pgPwA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-GUID: T0kMQcOkLsR0igX4_rg06_poZI4d8O_F
X-Proofpoint-ORIG-GUID: T0kMQcOkLsR0igX4_rg06_poZI4d8O_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270081
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey,

On Fri, 27 Nov 2026 at 02:43, Xilin Wu <sophon@radxa.com> wrote:
... snip ...

> Hi Chris,
>
> Thanks for testing the series.
>
> For issue 1, the Iris init failure and SMMU fault might be related to
> one or both of these patches missing from the tree you tested: HFI Gen2
> support for VPU2 4-pipe platforms [1] and the missing Iris IOMMU stream
> ID on SC8280XP [2].

The two linked patches solve the first issue!


> For issue 2, I'm not sure what's causing the hang during the password
> change.

The second issue was quickly uncovered after adding UART - it was the
SError you mentioned
in the cover locking up the device - which of course
https://lore.kernel.org/linux-arm-msm/20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com/
fixes.


> For reference, this is the Linux 7.3.x branch we're planning to use in
> production [3]. It still carries quite a few patches that aren't in
> mainline yet, both for stability and to fill in missing functionality.
> It may be useful to compare it with your for-next build.


Thanks for the quick advice - you'll see some T-b tags shortly !



Cheers!


Chris

>
> [1]
> https://lore.kernel.org/r/20260915-sc8280xp-hfi-gen2-v2-1-c52075bc284a@radxa.com
> [2]
> https://lore.kernel.org/r/20261030-sc8280xp-iris-iommu-v1-1-1e3fb8562b3d@radxa.com
> [3] https://github.com/strongtz/linux-radxa-qcom/tree/linux-7.3.6
>
> --
> Best regards,
> Xilin Wu <sophon@radxa.com>
