Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54489F9D0D2
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 14:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB2510E34F;
	Tue, 14 Apr 2026 14:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMMyTpJ0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eMr2h3MW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D7210E613
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:48:12 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EB9mW4363068
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 asIz/goXM85jx8Mtx/IA42gOXbEjTcLDg3RNbVf0uDI=; b=TMMyTpJ0SSjVBYqU
 btGRqb3op5XUXdbZUaFI/uSd8zvCXcYPVd3/mmffHe8p8C8r0FtY217bMo9vQJPP
 QL2lW7JB+JtX85N4SMFL/iKURvd74y4ej7KLOW8Dt+3GebWPKY9h3PhR8gXYcuqA
 VWMivjyVlPeIQuBuffqCVQXtppfc3P95pEpjoH8EpsSrZLcQj+G8MaU4+75y+QqQ
 7GRfhzEIOGEE6azrOnT0QHtTO2nZ/WTRfGkZJSzSKGwTfkEhHsEa3mf6TGd49yIF
 /wSiS6wyNGOxNsnAwJ8Y/NW1RKa7TPFg1Ro7s8xekkqgFYBKr8O00eli3xYTdaa6
 opMQQw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870u6sb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:48:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50db373cf13so9341621cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 07:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776178091; x=1776782891;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=asIz/goXM85jx8Mtx/IA42gOXbEjTcLDg3RNbVf0uDI=;
 b=eMr2h3MWhWBUQ9M0oa19j3tCRR7gtrBjxfKTSiz6RZyyoWPsLqFt3d+Oy4rYNIz/QE
 tMCXovEYjM5/panBz0w9Wn8UUrDvABmYjLTnLgtx1RGnnCBjgXif+Rg3uuOBaI3UCOHs
 BsVfuEJZQyK8YbX/yUDIO3/+AAMoNLUoV2A3eRaiBX6NaqHGf49kNazkf1agqUd16KOw
 ZIeTGOvMgcfpwblMpGqwZkuCJLbqkry8pDQb3zeAwTpw7WMQUSxmmi3N7h8dxRj6nPAZ
 9TuYgYkeG/DT6F6Uf1e2LSdzWYhfBZW8E2RtYMJ2BcLdxxM7qcXbC18ySj0HKpH+Ri21
 y/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776178091; x=1776782891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=asIz/goXM85jx8Mtx/IA42gOXbEjTcLDg3RNbVf0uDI=;
 b=C8qcTqiJDc4Qu0fELfp9OBNeIbp3sK+1cPZ9nL7FALoaYa0TXA0FDJOc6OFUmH81vR
 b+uoSAtVp6mLFrYqbfJqIaY+OgTIQRouRg5fSR5iR7R2Hi/zKUzxYQN8BLPN2Fg6/TjA
 j5ICrKTcSe9B+T4zFXBZfcTrUL+cLHEXxr+Z2C7x2k2ngF/UbSRsE7JfpI3E357djvbf
 mClhOG9qF2kbpOlD19EQuXq7JyqoOX/Hy+FAXXqWurD1mAZM47Wb1vjeYZo2IJuZumHC
 A19vWYdBWtLaPzqHO40mQnLakuZGF4dhmo0jEe2srXHeU2/U+XkhmCFUvF5NPr0evPGy
 7KqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8L3ZN88A62DVaSJiY74cHaZri0aOyTJjGNcXqCLYVEHAV059zRqcAMcEKVHFlLqqRC0z5Th1Sqyrs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOimcwBUKt2hg1NTZjJ/MU2vd+gL+Guz6Z4vh5lTZ60z3rvTFi
 CaYXBdgygKbpgQcbDT0cS/lbumrcOi+uOyPwfqnt+Q508CQr4lC5N8ehxgLNeykcCFP1e15/SOY
 PRzxTijLn/H2TjPqz3rjGCCa5gQGsu7ncU+DE5iM0M6zJHjOz4z+mEwuJ+UJyZs5GnOvXxwk=
X-Gm-Gg: AeBDiesm1qypuoqKWW1aMyZyZdwhis0SZR2BzhNjWfyox6JYVU2h8DHQ0+PKVsmMpds
 yo82hj74+RxW9dOQcyu4hKZHH9cBJrvOnu/NFoFRKyLNkpEejb1OW3rSZk4HEJbqc3ULRtv/iV8
 /8MjBTnyiRrqVf9Cd2U2qM//PfR1UQThe/7fWNnXV6umSHw8ua4abKaH+6umxbExM4+tog+oTzV
 lZq/HG5TyEa+qY8NONvuQwQ9X5t+xVLpqY70TtpWxR/PNJviZiNT0exvkQKSXhQrYLwKUDSeQh1
 CZqFDIEjMjPpj+lMtFN782JaNfCOV78DKJRER8VPF6jDf3Z2ObL70WPtqf7+FSR0lJueb1Z3CAx
 kX5BXLGeVug6XKpTnWl6VqOG0HmjcJvDmsncVKWZMWDTmrK9LjQ7KNvIw3xRihtzGASYT2AyFBI
 HNHQzKwLi4onyu3w==
X-Received: by 2002:a05:622a:98e:b0:50b:8ccc:a41f with SMTP id
 d75a77b69052e-50dd82add60mr172439631cf.6.1776178090619; 
 Tue, 14 Apr 2026 07:48:10 -0700 (PDT)
X-Received: by 2002:a05:622a:98e:b0:50b:8ccc:a41f with SMTP id
 d75a77b69052e-50dd82add60mr172439181cf.6.1776178090154; 
 Tue, 14 Apr 2026 07:48:10 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-670703f1340sm3291881a12.10.2026.04.14.07.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 07:48:09 -0700 (PDT)
Message-ID: <6b19880e-83b4-4811-aea1-dac6cbdce2f3@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 16:48:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] clk: qcom: gxclkctl: Remove GX/GMxC rail votes to
 align with IFPC
To: Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
 <20260407-gfx-clk-fixes-v1-4-4bb5583a5054@oss.qualcomm.com>
 <73196147-0133-4646-927d-dbe93c254286@oss.qualcomm.com>
 <a573a9cc-7426-4d80-ac9f-e084e72207b2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a573a9cc-7426-4d80-ac9f-e084e72207b2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C9vZDwP+ c=1 sm=1 tr=0 ts=69de53ab cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Kn1p6E0Hg4E-9EtVOsMA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzOSBTYWx0ZWRfXzZ+SnTfAXwmp
 ek3RIT1LqtfBePcS/R29XU0fVJoF9AnV9R4Zw41H9SIW3z//rITU7p3rVY/P1Nvfvck5UScbr1z
 p19haG++yzMf7NcO/alBe4cBfERuln8WJa76OyXv7+hb9ZrpdmgKYh8r3xo1vMTP8SGq/KmhBcj
 h6jTZwD4BVzVsffZ47CvTIVv+lnU7nXR+B0k0TsJZyDC0WZGLNI61RFRTAZPGI9GTB599Eb+5O+
 yuRbAtZ3Y0pFK1XXdbkg2U1gSvOescI8F8opLi9lYvtnWwfZpf8OOjGUmvrPz9EfqfrnCPeuj56
 pt2SA3wlJdLmivCaEVaks9teKoDiI3zvMbqDUmc5NBU4oLS6L3INU+Pi7bs+1snzQsvvcJIwq/X
 HrTNi5GKzdYKZFNTM/VDyA6XoD665dLhCwoZovxBRmQgLOQHf5OrNZDVA6b7Bgu786pD+gkMzei
 PieGhZ1MssuTPN0ltlQ==
X-Proofpoint-GUID: KmGMfW0G03TCJgLxM4bdUznQHDuF3kbm
X-Proofpoint-ORIG-GUID: KmGMfW0G03TCJgLxM4bdUznQHDuF3kbm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140139
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

On 4/8/26 9:25 AM, Taniya Das wrote:
> 
> 
> On 4/7/2026 4:59 PM, Konrad Dybcio wrote:
>>>
>>> #include <dt-bindings/clock/qcom,kaanapali-gxclkctl.h> @@ -61,7
>>> +62,15 @@ MODULE_DEVICE_TABLE(of,
>>> gx_clkctl_kaanapali_match_table);
>>>
>>> static int gx_clkctl_kaanapali_probe(struct platform_device *pdev) 
>>> { -	return qcom_cc_probe(pdev, &gx_clkctl_kaanapali_desc); +	int
>>> ret; + +	ret = qcom_cc_probe(pdev, &gx_clkctl_kaanapali_desc); +
>>> if (ret) +		return ret; + +	pm_runtime_disable(&pdev->dev);
>> My understanding is that this works because we have more than one
>> domain associated with the nod (so the generic code that would
>> otherwise enable a single one so long as the device is resumed
>> doesn't apply) and your previous patch ensures that after probe, the
>> clock controller is being put to sleep, right before
>> pm_runtime_disable() executes.
> 
> Konrad, by disabling runtime_pm will ensure that when GMU is moved to
> runtime active the clock controller is not runtime resumed, which would
> prevent the votes on the rails as per IFPC expectations.

Right, so the burden of only accessing the gxclkctl when it's got
power gets moved to the driver (which patch 6 assures), got it.

Konrad
