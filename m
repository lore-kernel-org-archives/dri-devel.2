Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA220606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lEYzziPz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IEYbeAef
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289A810FF8F;
	Thu, 12 Nov 2026 09:48:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34EEF10FF9C
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:48:10 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC9ZEV74092560
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=; b=lEYzziPz3E3wXE1N
 /r8Q21KLI0GSOoZbw37IOQi+XRe64yyHxO4KJMKXyD6wHBr3+uN2A2DqG1aZFVCb
 td0orAtjRp1dC4j/KyPqG5d96q5y7vKMm2BKTOKsdt1dlyUwp24z+1cEnebHmiba
 lsmQibx194c8rA9m2TXh3aOD9i7AI6KxyLK00WTHqjhvlhD4uAN/bB+W+ouD9DVf
 YFu1UNcSm+Up02WumBc+r6ikblrY5kMlzpu37riEDvTPfzmaBSpLyb+pCef3TTpE
 LJnjDCjjnF+Cz0U9C2aBPvT6jwMkRiiKlKn3l4dQXbHdnu8pkdbQTpnhKR5UBEBO
 sdPQmg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8j8ct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:48:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so7179742a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 01:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794476889; x=1795081689;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=;
 b=IEYbeAefrplGoJZ50ZrFLkNPuzMrjSX9ASzTQ6svOHlSADLtPwpSZ7l7Rj3dHnMeGN
 dveBhAgLC7PwDZzWenkSaiNnTOpHn51/AIKi5MYKYZh7gJwjuA0B73ASNtdhW5qhWGzW
 zd+05dCnfCDWsYLeyhRhBKs4cVutfrGt5kwxfZSKOxAx7gykEJ7vcG3+J/mnxsvpdN8T
 Xv1roD/hMs3XuWEmhqB8uQT7ulmXiGvetIqCELwvm/BGku6H5OKVhzxyUJt8H6m+wewj
 QwInYvN4yWyKkER4NOK9TwOvkJUKOJLNMrENR5qknnw9v6dJJwf6/Hyw8+6O1yQqAEBg
 udFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794476889; x=1795081689;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rQ0S0zFJsG83541wAchvZ00WuoVJfA2hSRmQg4ozNH0=;
 b=yErTLpXx8anafGDrAm/xo8OG57PrCWBexVqFjKxVmdc7iLj7QIvyADxlxGI9hRV4t4
 avBwPiXIP2/wcAWqGeh8w8vWVTb8aQYM9N35rxeJJL2RHnCURqfaZ4GV57bhqASwfiiY
 ttwlNE7O6AWPiFQq7e2JXJFKpTJRx/NC0he8xBTpO4SBC3ar1/eIK9EtMgVMJObkjkk/
 uH+Da4rbkyV3M/zwgzcIWgIUFn9E9C1hOLacuMPlCxQuAfDy+TwfMb/qT7aFFGAiswbD
 h8VOOlZSnezb3aWAHgsPE2QVLXgJrSVjyi9q9K46Wt/AwWpquHxhYCJXhIOcJ6YPkcNS
 ssTA==
X-Forwarded-Encrypted: i=1;
 AL+hErEWXkLl8UFj6SANGCXTHNGLMcmzVebUh9cuTGTvIor/Qflx21LztzhNLsgZFbffav11QullZDQGAuY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z87rXz7maZN72tCgjiHm4b2q3jPB4SnyGAcSr2T+hRt2RQah5O3
 CJwJSdjNivCdJ2x9GriapKmUsj2e8kXPTpEALDarAnXkuhriGlgqjdY+gb1Himoj71Vrxxl05I1
 trK7sZP1e1Ou47F8UODdU4j/tQCsh7iGz8rJ80AViUYdlCuIQStTXkh8Ukm6lzQQwLQyguHg=
X-Gm-Gg: AYBFou14peE2ikQcimPiEFHvQEadSj+MkaR1ZLRlCGPP1WS4TxUhGtTTc/uDlSOK2DH
 cI4oKLbrbFajd/mG/cRAcWFJib1HXYyFMSTrNRItnZCbTNRzUuazswNC2e96v77Jil0OmKZc8vA
 rdUxhZE7oAO/OrVUGjY5nQHjrU7Gkn4WKwMCMxBvl6YmEbY79RFjGHDjI+QsUJx4FtXkQIQ6wed
 z0I2tI5qPcOlbSRfcjyM9g5/ie+I2UpnJoSX+zTwM45w6pr7vZXCtTgGbOEnz9hSGt1f5PpHdYr
 E5RP7GcKcYhipRTCPfh7lpvTdsrrr0qiPUxi5BRPxQyfp4F0PN3uWlGmFk2g2yKBV1Rly1fmerr
 Mr0/i/LCDFUtqrQHRib+zT/pr/BcN7j6Ppc+IVpOpEUH/eg05Cfld8dOQHJQKGeID8MlMhoa8jL
 6Cu3uHwv4=
X-Received: by 2002:a17:90b:5247:b0:3b0:a9de:9886 with SMTP id
 98e67ed59e1d1-3b182e9457fmr5003641a91.12.1794476888810; 
 Thu, 12 Nov 2026 01:48:08 -0800 (PST)
X-Received: by 2002:a17:90b:5247:b0:3b0:a9de:9886 with SMTP id
 98e67ed59e1d1-3b182e9457fmr5003594a91.12.1794476888303; 
 Thu, 12 Nov 2026 01:48:08 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d0fdbdsm3913394a91.10.2026.11.12.01.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 01:48:07 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <2932200c-d930-4d5f-a308-0bde202af349@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:17:55 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
 <fzchmbho74ii6d2zhzni4qy4g74hiwv4fwf5xudrqdrstt6klm@7wdoo4acr6fm>
 <0bf2075b-e507-4b81-a563-f7b4e7e2cbc1@oss.qualcomm.com>
 <34hgm3yw4z4kbulvgpg7c2iunyui5ljn2l6fqq47prc7s6hycn@c2rnwvhcn5x6>
Content-Language: en-US
In-Reply-To: <34hgm3yw4z4kbulvgpg7c2iunyui5ljn2l6fqq47prc7s6hycn@c2rnwvhcn5x6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfX6jwos914YsDZ
 TOWkwsdKdsfIlBaxwR2JSzHWTXOvLv/f7lj9WtBJb4Qct08rMwFd5RKedpHUjeTGFimG0plPIIS
 KsUZ9xg4xtmCxJKgtOpgkwefQaxhI5s=
X-Proofpoint-GUID: jrBa0uzODziotDFM5qUx6sNKqhB7u4Yd
X-Proofpoint-ORIG-GUID: jrBa0uzODziotDFM5qUx6sNKqhB7u4Yd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfX+CbGHFNwsJB3
 aB3we+WXdO09REekJG+YRWX9CLG/cqZnPoFiUKQiutqOa1KuKZgvowDltkoJGJhODN1IlGgTJQQ
 kmL8P8zuCbAchmGx9lSHN8KQUbo4bdl0UsDkf/xrU3NQjaPPDDOiCppFwi7/6SQ0QbdUBx+2pWJ
 AjciFeHot1UtUgwrGusG4rzZVCpZuCFgRX9BsWYWv/YuYVuZlHfOTvUnV/8oH53bTdnhvx2iTpw
 bsIvFP6KVRBgXVlVaJvwJWeFmBds3B/ezlA5em+JofR7yUAZfT8CB4iVl/kdI4E38FiSknWd0cj
 3oAFFlpeweWUKYKXaliZvmI0+7z/qrZmbuLHEWmzLYItxiuDuJu3irf3MATaJlzE4Bh9KHvaySf
 j253mDFmiav9Jka5gyYxGilBC6BQLBR7Lp/DpKqzGk1qBgHMU7nSIMYRjLhdRa/VjnCJ9Mr0bDc
 X+anCT7prqokSgxnk8Q==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af58b59 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=8VBehk7qD7xQtsfHT0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120038
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11-11-2026 19:43, Dmitry Baryshkov wrote:
> On Wed, Nov 11, 2026 at 12:38:54PM +0530, Jayant Shekhar wrote:
>> On 26-10-2026 15:27, Dmitry Baryshkov wrote:
>>> On Mon, Oct 26, 2026 at 11:51:11AM +0530, Jayant Shekhar wrote:
>>>> DCP platforms place the display pipeline under firmware control, so Linux
>>>> cannot discover display resources through direct register access. The DRM
>>>> driver therefore needs device-tree descriptions of the Qualcomm transport
>>>> wrapper, display topology, IOMMU contexts, and panel connections.
>>>>
>>>> Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
>>>> subsystem. Document the IPCC power-notify resources, transport and
>>>> framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
>>>> DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
>>>> after the IPCC power-notify sequence has completed.
>>>>
>>>> Assisted-by: LLM
>>>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
>>>>    .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
>>>>    .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
>>>>    3 files changed, 334 insertions(+)
>>>>
>
>
>>>> +
>>>> +patternProperties:
>>>> +  "^dsi@[0-9a-f]+$":
>>>> +    $ref: qcom,dcp-dsi.yaml#
>>> When adding DP support, would you add more devices at the same level? If
>>> so, we risk getting a warning about multiple devices using the same
>>> address.
>>>
>> Is it good to model each firmware INTF as a single interface@N node carrying
>> the INTF reg, with the protocol-specific DSI or DP description nested
>> beneath it?
>> The driver can then obtain the INTF index from the common parent, avoiding
>> duplicate addresses across protocol types.
> Yes, it might be good, but it's not what is happening here. You are
> adding dsi@0, although, I guess, INTF is 1.
>

I raised that approach before v3, but the patch still uses dsi@0 
directly. I’ll update it to use a common interface@N node keyed by the 
INTF index, with the protocol-specific DSI/DP description nested beneath it.


