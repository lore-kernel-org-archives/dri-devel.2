Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFD606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oFND5jF5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XZ/TznYo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C09210E124;
	Wed, 11 Nov 2026 07:10:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C30E10E46E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:10:20 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5Kbxs1343907
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W3qNx39FMf1BOTjwvebsKoIWWMVE5mBaCfEA196G0ts=; b=oFND5jF5muk5SSG6
 x9JOIMx9x232dA6O2ATNkn6sWV0UodJv1+B2e7BRi/puHKK8AUR3TCKzZSGtSHU8
 9svUKvzTsi+LNIBpG9WUmauSZVAz3i+BsmJrYHCyEeM/hFW/FH6qgJ3hgeWL35Yv
 uEftjHP0oJPJe+MDww6tHw6iOIcKMTigexvq2AeX4u1fK6vZzGdfnQcYXYTePa2I
 4Q0VtRd+Bvs+LivjFQxX5QASU/L4lovBjKv13Z4D++PI7GQCuH3Ajy6p4jxbeOD8
 i8JlOF6Y5oHK1md08FgF+fpfAeasxFiVwtIyzC3O9rDt6zLdXM/3HCe5kkA7ymTg
 ak0HgQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyufvtra-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:10:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f479b9819so5042336eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 23:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794381019; x=1794985819;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W3qNx39FMf1BOTjwvebsKoIWWMVE5mBaCfEA196G0ts=;
 b=XZ/TznYo5bE/R+0Do3raEDy/XdG3vjkXx+eRgwMSYptFJpOzjSumYdxaXQVwAAhU/J
 IEkNXVWpTLq7sGeVZmO1+4Xs9DU7mrcMk6IUVnYUHU6NDowIUNhS7AV3Od4BIgDlUUFP
 HX9ooDbAsau98sjmC8n7KBx2Hho3SHcy8ZsMOPWkhCeJqSAoTkVIgR11DRoqKnoeW0Ki
 mGJG26F3OEYWlXuSVkJiusHGGLV5dADjMAo6jj+XS5WE85gVT/GHYQxwQXQDi9iAFaDc
 PNCsHvYJM8ZESPkTw0MkMmKn7xaPOPtXJWWHwDcpASdeyrZW/BJsaIsz9I35UZZayq93
 nfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794381019; x=1794985819;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W3qNx39FMf1BOTjwvebsKoIWWMVE5mBaCfEA196G0ts=;
 b=D4z4T4dsXc6MpnzEcpWdo491urt4wzF8CtNhmVyKNeY98q8GngwMI2bwx+lcslUOxz
 KN4tfgqKyp0hhlTsg6atHCk91RD9+9IvS7sr9IELNP5KrbCrPFlV+2c7dEovS/1HVSC2
 0Fc+SKjUrvRImSBacrbvavJMd9Bifgm+u2eun3wJOKK0tPgwG7Mwq5l6cJPHiNm8ofLR
 HfZyV4Ybrh3wxni0KywMOtU86j85Qr6CJg5SbxXTAHFhanwQr97tEuz0Ot7orGXmu3FW
 Y8oP6tVSS5nWwDL+ij+tsFQDp08O9VKPGO8maBj+vdYAyKOeO9hU9n4ie3+S3kHKmzKL
 lyOw==
X-Forwarded-Encrypted: i=1;
 AL+hErFJKD0mncUqg4DiGqBdBgaRtJixaB06J1XFlyjCfHhxrzniwgmWP35vau5Bu5A4EgqeGHM2mmuL7jk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+zZZjEqDUnJGuPJENxvjeNWdiw2xBbNnAV3k9+TYbglkwRkFrS
 HFTzuuB4mM0IJ6uNcyLdq8zEKi+DjUQsPQKbBEUoFzXMbFkCnquoEzbl2zQ9O5q+/Pm1MeAb2x+
 orJwKyBfI8uS0GPnnxHeIR4Zj6wrN38/LkDZu8MM1JYIIKRkRbGPVEOjR0J0q1cW7XqB0fXI=
X-Gm-Gg: AYBFou2SnTtJ0t3v56LdbYk8z/8TPD6d1c8iKN94ArfP/H4gBJCQUeJE3F/x57nkecy
 IwNaJDc+f3PI2Cc9KsU1111+EFtW52bMf/0S7TZv35V2usxfZrbk8UtjA+FwfCX2GnTvjSSbk9N
 ORWLsmPbtMFvsS5ViBdpMN3nLze+aHY7Srs8VkNW8URYoAiWQJ99VJlrmo4D91U6qalnbxOhxvn
 +ROTXgtsKKbQAmD6Z8ZoV5zgKgnKk3AT0yMKi1SsRPuTP0SuszKgjCSZrnCXGykaxLGfvCfvk9k
 LQAWvkYNc4hgicqeF/aF3XMDe72CQjCiVT8XGLr5AVGnolKWKKlaTje4+/fwfiKUiKGjVjQPC/1
 QGyjbH0WPFE4J2IiHDWUqD5X0PY1FW4bj2WWcruyCGc5+lKyuk+VadYBzmMrjzxzGQo22UB3M3r
 l1X85UUc8=
X-Received: by 2002:a05:693c:62c3:b0:36a:1e9e:ae61 with SMTP id
 5a478bee46e88-37687119518mr1917694eec.38.1794381018936; 
 Tue, 10 Nov 2026 23:10:18 -0800 (PST)
X-Received: by 2002:a05:693c:62c3:b0:36a:1e9e:ae61 with SMTP id
 5a478bee46e88-37687119518mr1917632eec.38.1794381018145; 
 Tue, 10 Nov 2026 23:10:18 -0800 (PST)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3752060899asm12686718eec.11.2026.11.10.23.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 23:10:17 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <2fb9fd90-fac5-4a9e-ac7e-5dde689d8b80@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 12:40:05 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/23] dt-bindings: display: msm: Add Qualcomm DCP
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Simona Vetter <simona@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 linux-arm-msm@vger.kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 devicetree@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
 linaro-mm-sig@lists.linaro.org, virtualization@lists.linux.dev,
 Jason Wang <jasowangio@gmail.com>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-media@vger.kernel.org,
 Mahadevan P <mahap@oss.qualcomm.com>, freedreno@lists.freedesktop.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Bjorn Andersson
 <andersson@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, Abel Vesa <abelvesa@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Philipp Stanner <phasta@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com>
 <179304379330.2965544.11793708430519844335.robh@kernel.org>
Content-Language: en-US
In-Reply-To: <179304379330.2965544.11793708430519844335.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aOEi4Gw0DrANac6LAVq6Rrod0Aw2H1de
X-Authority-Analysis: v=2.4 cv=S6lMU4sP c=1 sm=1 tr=0 ts=6af414db cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9TjDuG0S92mpM2z4UZQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: aOEi4Gw0DrANac6LAVq6Rrod0Aw2H1de
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX3+lGMS6g+/Jq
 qWbw8cA95CFpXsdXMaI8UO8WGxaV0geW4o05bR9jxwD6M1++svjia5w6BggV9vi006/ZhU1/YCq
 qFLqw0w7/Js/HvqF3yOD7CyoFe6BwKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX9R9dUI17+HOY
 smPmHBMxW6BXGMS+B8x56WXR4gFk6dGI/VEZLNkKJe2q6y3Yh7IbSd4ngBmlDC7B2UHlcD2LVT1
 WCIrrvcV5pcXJYKKGvBDGLv0MqOEtD4qfkRBg7rVAJFDDljMyCENYMpDo75zSfRX7wJ8XoXQnDI
 U70l9O3ZM+hfsq39nJrsrZFM3JUVs805+mEvnwL7eYVlJNJqqc6b/cnOWkMtWVVeFdIaU1tkBU3
 2o3gazy7UcA/cLfe4110mshw6dBPzGnmKSek0Dg3QKd3JWMf9TVG4npIN3XxH4FjzvBryZ05enr
 w+7NEM/0JDDR84LaAdowCR6Dg9rNELgF9o0Urmh6zVRDhS6Y7rjrf7tn1dm+bHN5GQXOeuJV509
 T8yspPfqcgccf3zSwIKptaTeL8TDpbkgWcqqhP/3rin8CSkMM7Y6fmkXy3y6lDygdJUHTESIe5F
 MnYjj8GnH4y60j2PCAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110028
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


On 27-10-2026 01:14, Rob Herring (Arm) wrote:
> On Mon, 26 Oct 2026 11:51:11 +0530, Jayant Shekhar wrote:
>> DCP platforms place the display pipeline under firmware control, so Linux
>> cannot discover display resources through direct register access. The DRM
>> driver therefore needs device-tree descriptions of the Qualcomm transport
>> wrapper, display topology, IOMMU contexts, and panel connections.
>>
>> Add bindings for the Qualcomm DCP transport wrapper and VirtIO display
>> subsystem. Document the IPCC power-notify resources, transport and
>> framebuffer IOMMU contexts, firmware-visible IOVA range, INTF graph, and
>> DSI panel connections. The wrapper creates a standard VirtIO-MMIO child
>> after the IPCC power-notify sequence has completed.
>>
>> Assisted-by: LLM
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> ---
>>   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  79 ++++++++++++
>>   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 123 +++++++++++++++++++
>>   .../bindings/virtio/qcom,dcp-virtio.yaml           | 132 +++++++++++++++++++++
>>   3 files changed, 334 insertions(+)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/virtio/qcom,dcp-virtio.yaml: iommu-ranges: multiple incompatible types: uint32-array
> /usr/local/lib/python3.13/dist-packages/dtschema/schemas/iommu/iommu.yaml: iommu-ranges: multiple incompatible types: uint32-matrix
> Could not decode node virtio@9be8000 property iommu-ranges with value b'\x00\x00\x00\x00\x84\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00'
>
> Traceback (most recent call last):
>    File "/usr/local/bin/dt-validate", line 8, in <module>
>      sys.exit(main())
>               ~~~~^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 443, in main
>      dtb_diagnostics = sg.check_dtb(filename)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb_validate.py", line 331, in check_dtb
>      dt = self.validator.decode_dtb(f.read(), decode_errors)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/validator.py", line 631, in decode_dtb
>      return [dtschema.dtb.fdt_unflatten(self, dtb)]
>              ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 591, in fdt_unflatten
>      dt = fdt_scan_node(validator, fdt, '/', offset)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 320, in fdt_scan_node
>      node = fdt_scan_node(validator, fdt, nodename, offset)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 320, in fdt_scan_node
>      node = fdt_scan_node(validator, fdt, nodename, offset)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 312, in fdt_scan_node
>      node_dict = node_props(validator, fdt, nodename, offset)
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 258, in node_props
>      props_dict[p.name] = prop_value(validator, nodename, p)
>                           ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/usr/local/lib/python3.13/dist-packages/dtschema/dtb.py", line 185, in prop_value
>      if len(p) / type_format[fmt].size >= min_dim:
>                  ~~~~~~~~~~~^^^^^
> KeyError: 'uint32-array'
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/20261026-jshekhar-dcp-hlos-v2-1-7cf014efdee1@oss.qualcomm.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.


There is a dependent patch which adds iommu-ranges, I had tried with 
that locally and it passes.


