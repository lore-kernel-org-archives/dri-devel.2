Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C2606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U7fHBr2Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mi3eqoa7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA151129F6;
	Fri, 23 Oct 2026 08:10:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 458E01129F6
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:10:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FT072650369
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qt1u1PGQnVLwLZKEH+hp9Dtkn1RKbERmxA8BWP6q4N8=; b=U7fHBr2Zzr5BzR0l
 GZ4p+H51nKm9WVAQPxZtK5Fxkawu2eyIUw8uq1dLaEEiMmoXZzBSEOt1Ca9eoWJh
 Lmldut7xSV7XBgCfpN1LqCL+BlRp56ZaYaSsa4GwxE5GF1t7f/hD6UuuO/Nb3+Ie
 pzBPhe/0u5Dl7/AVXrCPWXw/OJQQoSxrCbRu2YwIGvD6Eh/ZW3w29qV+5Ex5n93u
 V0Ekb2Macw7YJI7/WfuTkPsM2grc2qboRWV1y9a+c6TX6khVSg8MVWZxO16ccf14
 DwWONyUX847Rs1JDb87TeUaYuMA/se/zirkPxWskU8S8qCLB8g+30G4DDdGoCCK/
 zHAsZw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjapkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:10:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3adc5b185bfso716623a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792743038; x=1793347838;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qt1u1PGQnVLwLZKEH+hp9Dtkn1RKbERmxA8BWP6q4N8=;
 b=Mi3eqoa7WcmfvMMwyeCG5Ty3X5VzPkHso6YOV7/a/Kvs6qtV1CgTK+sNsGvk7LGazQ
 paAfS7MaFX2w3A2vu/B+4vDDS0YW9e1EYxU6t73o2L7DeRHA0Ysm5CZ9AkEqVVofML0z
 n6PDxsZRCOaQSzbMxCi/WWcS8eG0bj91h1nZ/lMFnZL6ygZNT2WZZYfRYiaUS9UsNYxg
 D06n40qRlIeUWvOMnIHffuttUVV3Eg8dbjU8/Wi/6MtXARIapKgItM/d7AuIJfqwLlhP
 cg0XKWckhgkzOr49GITiSNx2dhtpdF/zCw0fbHsnbAykLx4QfZYhSYzaLCQuEHlEXV7o
 +3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792743038; x=1793347838;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qt1u1PGQnVLwLZKEH+hp9Dtkn1RKbERmxA8BWP6q4N8=;
 b=MMt076b7Pz5BCiWb/nsh5b8/me/giDQzo+dCJnxNAH8w5p9+Z1i3iIxSAsWKDomPnH
 tKNcC5BS6/VRIMBENDMV5kA6zVeXEnNEnH49eXvFVmj07g4TKlQaoV2Y0bYLPkISAi4T
 fh5LT45d2qLw5wpNgfgi5CytiYn/UeH7VbL3RwIbmPdqRZrrkm91qLMCKs5b92pUe7YX
 GXde6MkUKvRErlwci37X/KdVPzW4hyYlf50OHvOEml7dh0KoJbgJkLNk/lRrXhwWQ44w
 BLrt/OXn48TgoCfCEOeZ0zGwiPMFoAW6wpdkfjh7oHieZtD1QlAcSV8pqsUHbE78BjZW
 3D5w==
X-Forwarded-Encrypted: i=1;
 AKwUvByIkvS0YuUfZ5uTvrKqE4TDEWy4O+5ceu5Fozys8bv+JtsHlhoW9EsWljLR1NhJD8HdSwVvM7UHSN0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL/IonzjXxdmlfZYTTCS/T7IVTykh49t84I5j2NIvn7KAS10QvZ
 XbzkqPEHg5Ffz+dMZSKFznAROhkjHC4yRp4wEaNGp277kQUTZ/Ztg129Q/fT4AZQ1gjqaTNkFzD
 KqKaWpqvHR4yTJwUpUMCirxvkZi5Vztx0aKDPUpUX0F/Id8fhNYUG7KyIyjnU6ULEL/fkEaUCoH
 P4Icw=
X-Gm-Gg: AYBFou0s87rRSFGZv8U+8HSB5ggGD5gX4dgxC/o33AsLP2GKcunGwu2Qo3/UqagxxQ5
 lnRAFog6GPhuwDHQgQkFHptuI2d3dLI28B8eL6vA1aalaIbMViKs2aBhxtgtsHM7k989memW6fs
 pImkbRQ/PK3qa9GPtdAAhIFnZlVcy2SrormmQYviCDJnYUluBuSDpnJy+4IzV3GerJzKwatA8j2
 oKkjrLM2tLzfUbD71+yAWKwaDPRz0iYqj4kfIb8/EKLbwyq1RllvATgG+DKUuZhdLBCK0KZoGCy
 Xe0BnTHHePBhFijvezBSnkie1qZtPnMPnCX2t84hGb+x146j+YlC9POAsirqSBUuMqEkr+vKH58
 4aJ3tObozxTgtGqFjcEyDx1ehBD3wSaIJhQ==
X-Received: by 2002:a17:90a:dfc3:b0:3ac:97e3:7389 with SMTP id
 98e67ed59e1d1-3adce072ca9mr1162564a91.44.1792743037994; 
 Fri, 23 Oct 2026 01:10:37 -0700 (PDT)
X-Received: by 2002:a17:90a:dfc3:b0:3ac:97e3:7389 with SMTP id
 98e67ed59e1d1-3adce072ca9mr1162541a91.44.1792743037308; 
 Fri, 23 Oct 2026 01:10:37 -0700 (PDT)
Received: from [10.204.79.28] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adcb0a11fbsm2517749a91.4.2026.10.23.01.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 01:10:36 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Google-Original-From: Jayant Shekhar <jshekhar.shekhar@oss.qualcomm.com>
Message-ID: <ae967eb1-cc54-4733-9e89-bc375e1cbfd6@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 13:40:25 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] dt-bindings: display: msm: Add Qualcomm DCP bindings
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-1-48aad0fe4f72@oss.qualcomm.com>
 <20261015-heavy-clam-of-sunshine-8fe831@quoll>
Content-Language: en-US
In-Reply-To: <20261015-heavy-clam-of-sunshine-8fe831@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3CC5AOBWJgqg2HwaEU7rGU-5pTQkVDDQ
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb167f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=P-IC7800AAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=CvYCOFMdU_owP9l6gQwA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX4wpB5g6Qhjz6
 jVtFZ/NZtH/GB3sueaxofSXONWv9bxYi/JVHf/1OzHcIUexQyL4UOR0VLzzH3qWNK/+AeVjfQGg
 QDb0ROe+dkhFtxMdDFH0k5zs32u7LV8=
X-Proofpoint-ORIG-GUID: 3CC5AOBWJgqg2HwaEU7rGU-5pTQkVDDQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX1NfYxsF3KsKZ
 DNehaKs5B90QjvFKm/Dd+jUMFd/xYHpY7oeB57689gnqNqM58+8blPbrZcdtQzF9A8oXPolzO16
 rTgLUyvwbX8RcmLwx5UeYAPE+4qSJ+InucWMYl29bCS8Pf8IeozM/wUv4baTFOYcURadrOc9EPU
 Pe3UyUHzqEApb8vNSLvPu3U1DOXXZ/Y2m6eVYmi9Fi+3QYOq3Qyuy/qMLYgJFrAUy0WoJm9yf3W
 NeY8Mey750WUyps9Yjdgw3kNg/luBi8RcZiZufL51VNU0LfbEYY2fnurXJhAnMYn+xQxAf0/o4Q
 UZrLKA3s1yiKRoKO6hhhbIaKMaHTx04cAODOHTIAWyKEh3zzA5KwjVXBDlYdlC8SfuYJE2+T7sB
 SUqj/6/EvMPtzfPtuKua3c+G1ct/sf5YRGKxEM7fRG53auGrXNvTNbayC75tQ1R8G9Oc9VwgiFb
 5UBAoLPoDLdvlUQ/pMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 15-10-2026 16:20, Krzysztof Kozlowski wrote:
> On Thu, Oct 15, 2026 at 01:08:21PM +0530, Jayant Shekhar wrote:
>> DCP platforms place the display pipeline under firmware control, so Linux
>> cannot discover display resources through direct register access. The DRM
>> driver therefore needs device-tree descriptions of the firmware transport,
>> display topology, IOMMU contexts, and panel connections.
> Due to dependencies this cannot be tested, so limited review.
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
>

Thanks, will fix this in v2.


>> Add bindings for the Qualcomm DCP VirtIO display function, including the
>> INTF graph and DSI host outputs. Document the framebuffer IOMMU context,
>> IPCC power-notify mailbox and interrupts, firmware display topology, and
>> firmware-visible IOVA window supplied by the parent VirtIO-MMIO transport.
>>
>> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> Assisted-by: LLM
>> ---
>>   .../bindings/display/msm/qcom,dcp-dsi.yaml         |  75 +++++++++++++
>>   .../bindings/display/msm/qcom,dcp-virtio.yaml      | 113 +++++++++++++++++++
>>   .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 119 +++++++++++++++++++++
>>   3 files changed, 307 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
>> new file mode 100644
>> index 000000000000..f7178c66c09e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
>> @@ -0,0 +1,75 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/msm/qcom,dcp-dsi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm DCP DSI host
>> +
>> +maintainers:
>> +  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
>> +
>> +description: |
>> +  A MIPI DSI host exposed by the Qualcomm DCP VirtIO device (see
>> +  qcom,dcp.yaml). DCP is a firmware protocol shared across multiple
>> +  Qualcomm SoCs, not specific to any one of them; Hawi is its first
>> +  platform. The DSI host and its connection to a panel are described
>> +  using the standard DSI controller and OF graph properties.
>> +
>> +allOf:
>> +  - $ref: /schemas/display/dsi-controller.yaml#
>> +
>> +properties:
>> +  reg:
>> +    maxItems: 1
>> +    description: Index of this DSI host among its siblings.
>> +
>> +  status: true
> I see slop, I finished here. Mind this maintainers summit words - if you
> use AI, you must use good one, not the shloppy slop.


Will remove this in v2.

Thanks

Jayant


> Best regards,
> Krzysztof
