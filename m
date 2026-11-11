Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E33606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ExzrXnKW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KR/I4h+R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C8010F95F;
	Wed, 11 Nov 2026 08:33:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71B4410F95F
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:33:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5Kp7W1052622
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jrBeNlBN5IOvDDr8G0t3/VlYmzMM0aOEx9XgntSJ1GA=; b=ExzrXnKWCIJuRBYW
 adlPonufNKzumfWmayEMC2ytP0DcBjWY22YFKn4YbEymsgJmsfGf64Z/I99EVESM
 Iwwh2NEDAYO1fknxf3wpxObrSHiaPMgb0dFAejfkLOjJozEtfs0tP/Roz1hQmT+X
 KNtOXCwzMXVzmymZPX2+ldNXcDr4IbSK4YAKqiMlVRRBBPYuSJ/b9Onbg0VyWEkZ
 5noTWZOHi925H8YZ6P2Y99oaUphEDMhKHnGufPJahXIykXXB56H5oUiV1Y0Ubc8U
 BMh//eVhierB+74JJRmF2uhNuS3jwvlB+rKcX39D23/HSmhcuTBivBjo2pZVUIOu
 jAFQ1w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh1mq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:33:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36ecd5db581so5218980eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794386005; x=1794990805;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jrBeNlBN5IOvDDr8G0t3/VlYmzMM0aOEx9XgntSJ1GA=;
 b=KR/I4h+RO/GR+1n5DqkrNM5H/Gkaka6Di0HsL++43Ie2trk6HgxBGaPWk7Fv5Tu0RT
 usykLBbPJT7M8/QbCOvCRyWHQf6Q7ihhCSZ6jIQ0Tw9cikLviiDhhXWC4CajRcc7Iz74
 OTt5G2iPZLVQPnnSYYKOYe0qRFd3FZSMTEOOIYTSBO1KiwU8t7NoMndw37PsEwfZVkmj
 dQgdiEymVnmBwxgqG5KiTcMnWiNv3TVX2y78T7ufp2zA2/KY9el7k7Rzs8fW8uPmuzv8
 R5xuhxKJaqXB0itiFPgEhqN5hReaPGtUOqQSF7i040BAkZs+7RZWu3JGXj04nnIjNg8K
 opIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794386005; x=1794990805;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jrBeNlBN5IOvDDr8G0t3/VlYmzMM0aOEx9XgntSJ1GA=;
 b=pVGD+jktIJ0dB6Hg1vIopDPNW7vLHG1P+OXMn3GNMa+wCGINuysX3/PoU22QE+xelM
 qW9M46RkJJ2sdR4V4zvlFeGUVGS9sgjLbRd0b2ag1yeorSp+Lfknt+MrKYrV35Y842Ix
 MXmkE02jr5/+LXUeesbTv8zXkjTzNVfaJsm6WpZ6P2xwBfyV0sTdVoAC1zJrzU4ubOQE
 g/bai1dChtvP9TcthtAExiSJf8bEYbnnPQ5dxW9a+xLXdy17C2dq7m/qmYl3npS3oaUo
 Wglkdm8mlKUP1l6oa1BTRV2BBZ6pjOg9Dq+ICasf5Vf4IybFKD3X1gs+S5xhx44LS5u3
 aLmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEZbYnMVPsF8nOK8YA+f7I+eBI4eqtbKx8NazOykbIXqp77HQQIu/TZN+wq5g12uFNrhADk7gLGBrI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9r/Iy8tSfqVrOiwWsZSqekOmi44Gy1yWx+pB4G8l/n8v+PoEcO
 /WjuKTbbeHGdMn6/bdjcqx9MxS937uii5NoE7UzTBLUmEnUvjoZBZySABH8vNlK6EuADba6RPzb
 uJFF0/bHzLSAinfRrYmHhc0PYJFuc2RkD0OVFnucqBSvfPnSVC1imbTvjDBNn+WvZs+WQiNo=
X-Gm-Gg: AYBFou1E0VvW9ZL+hsmgdnQImQclWol/wWU7rQYxjufaOuJcvJK0YGQ92S6r5+6B+uw
 TfaXAwUSRYuPdorxUITR6JwS2qYPa0X1lc1sI3P9o5H6EgF121zhx3J0KpbyGBOTbM8RogKrSx3
 wuD/d9jyRXfnPObTtjJhZsJAryLkBvm9kOdLOUXG4d5o70UDEM4zJ1Jl46ijkkBs8+TD+d8l1l+
 a8PguglAQgZUhi07OzK3/YNhpg/oNdQLSwpxiZMz79Pp1XaEeiKzD4ZVxK8Y88T4FH4dvfZRFxF
 dHcPbkR49+kIfZrOSenivWeta+ioiLQhkL3dJptPFwpPZKjYrwoOPVTsXau0AViKgGDspHBtTMM
 e76xjWTCBzVSOsqmC+r+qeexiHxJ2Woe5R+gbjD9IP5mPhot+KpDDQgOAJLwzCcGWNipOB/TfHN
 5feQ==
X-Received: by 2002:a05:693c:2a17:b0:36d:a465:b38e with SMTP id
 5a478bee46e88-3768395f032mr2455995eec.5.1794386005051; 
 Wed, 11 Nov 2026 00:33:25 -0800 (PST)
X-Received: by 2002:a05:693c:2a17:b0:36d:a465:b38e with SMTP id
 5a478bee46e88-3768395f032mr2455945eec.5.1794386004375; 
 Wed, 11 Nov 2026 00:33:24 -0800 (PST)
Received: from [10.219.57.104] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-375218c7c50sm26864637eec.29.2026.11.11.00.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 00:33:23 -0800 (PST)
Message-ID: <811819ae-ebff-49e2-be25-134b58711a5f@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:03:13 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/25] accel/qda: Add initial QDA DRM accelerator driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Srinivas Kandagatla
 <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, dmitry.baryshkov@oss.qualcomm.com,
 andersson@kernel.org, rob.clark@oss.qualcomm.com, jgg@ziepe.ca
Cc: lingtong@qti.qualcomm.com, cacar@qti.qualcomm.com,
 sandheep@qti.qualcomm.com, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 Ekansh Gupta <ekangupt@qti.qualcomm.com>
References: <20261102-v4-v4-0-88f2f24a5f0b@qti.qualcomm.com>
 <20261102-v4-v4-2-88f2f24a5f0b@qti.qualcomm.com>
 <c4f7b153-feb3-472f-b13c-c7fb0a46f9b6@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <c4f7b153-feb3-472f-b13c-c7fb0a46f9b6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzMyBTYWx0ZWRfX/Us7rJUh93uQ
 Od4/W4WChU3bTIDR2/AziiCYmTJttqKg0HarjuhVQ10Ori8xVpmwycpx39MkoYaxXCrREuEc7Ep
 20Vy2R8PL51yxc4HpZoAiQUfJzH0IDI=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af42856 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=3RgQX8W33KRH0BhMXdoA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: afkK-IbnlIseUIZLAARUJXqMDBTH4jir
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzMyBTYWx0ZWRfXxDWAuETOnWDk
 oxFvTiwhyuq+neZX8nlwfwz0GR7X8HdSE6F5jnXYtPHacTU1eTgpkC3nvGZr4uhzkvxbA5RpOsM
 6kCSrVuAfdWnqlxAeCYhQuxIXR5Zvuz/3xnfJNVXEZUu0K49X/6JDk4SYSZElXaBQAq624kIsSQ
 vt1xDCJkEKt/upiAWVQAj1PskW/tBnlT4kGq7+7AuMZ1rj5jspjyZguygN0t+p8pTFsLtWRUm5P
 2p+pY5+t5r6ZpdHwHQX93n2sDVvod8BxaRtzZCGu7yYiS74VyLGEfESSjhPflGnF8I+rCv5BIvB
 ed2tseT3CIJ6oPQ1fWAJDbusAbazL4OeAYnIlwmgTMxClacaKt5qssyv4DyN4TlBKOCzwqtRMwF
 HOKkHDaPo+bcUvm4HEUjkTiug1TLRObP84rYK6orJzfvT2cxa1ZXYpjmKXZvM+kOwyv/UWcrSEJ
 Wh75q6XlA97D0AEmXJA==
X-Proofpoint-ORIG-GUID: afkK-IbnlIseUIZLAARUJXqMDBTH4jir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110033
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 02-11-2026 14:12, Krzysztof Kozlowski wrote:
> On 01/11/2026 23:21, Ekansh Gupta wrote:
>> +
>> +#include "qda_drv.h"
>> +
>> +/*
>> + * Both compatibles the binding defines are matched here. The glymur, hawi,
>> + * maili and nord nodes name "qcom,kaanapali-fastrpc" as their fallback
>> + * compatible and so are matched by that entry. Per-SoC DSP parameters are
>> + * attached as match data by a later patch, once there is something that
> 
> So you add empty or non-working code. No, add these once you actually
> have complete and working table.
agreed, will add this once there is a complete table.

> 
>> + * consumes them.
>> + */
> 
> Drop comment, redundant. Referencing future patches makes no sense in
> source code, because there is no "patch" when looking at the code.
ack.

> 
>> +static const struct of_device_id qda_rpmsg_of_match[] = {
>> +	{ .compatible = "qcom,kaanapali-fastrpc" },
>> +	{ .compatible = "qcom,fastrpc" },
>> +	{ }
> 
> 
> 
> 
> Best regards,
> Krzysztof

