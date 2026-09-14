Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E7AC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87ED10E53F;
	Mon, 14 Sep 2026 15:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JpKZIH2f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FNEsGxdm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCF010E53F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:52:41 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0VJm3588169
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wVlvxm/so69i9rBF3Qqf6pqpvc/+LeTsxiPPuQMtYXE=; b=JpKZIH2f9DAXQmXH
 2iSP1VdlpJ0jceUw4F13wvvmhwgtDHYwagzFi0IhLy8fWf1EZBTsFWgxC2NtF+td
 1WB37/06bpqcAzlBAvfooguEFqC49IGSvPVLEjjDniBT5Wk0wufQgO3pvEHhA6DR
 vzmq7nW95tq33wdbJ61049JaWHRe3zZQo9rYHgZSTB3t9nBRWzVB7ZtP/fofSiWi
 e7XA9fOcoKAvtOLodW3OMJ5HOzHr8EhHdSiHkovtecswNEkJ/z+6GaUfDWFH6tn1
 lLDJrJtF4D74EaNcKXw610/z4fDiD6TCkV8IMdJyApCyirO2+QUisvflLq/wqhrD
 t9dkSg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gperg9eyd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:52:40 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-97e99aaaa6fso494634241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789401159; x=1790005959;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wVlvxm/so69i9rBF3Qqf6pqpvc/+LeTsxiPPuQMtYXE=;
 b=FNEsGxdmg5mQTZbu9pUTyCCDdGJkj7dE2u1V7HAiydmP4QvocqvlwdTCeqig1ownME
 c0QPGq8JlMGK3JOpA5NMinf9XQDcNRlqWYwsQ8Mlx7PLgTGmIJZmxP9Y9Z6hFTHpuvqq
 5YklvHph/sg8PZewocBKecPZdlfFq71uObEtQF2pebxkcHeisj5BXIgcQ4lTKmq1NwcR
 sXhod/nPwcwtYdJSbFVzzVdx6AYvkRGhPnpTKx48tm7EIMWNjcc5rcFODujgZzX2+3ih
 5ROcxvY09BaXUgc2Erw3FsUMX1gMbOCCmK8oqZnE0qmwf1vg3S2cvynt0rFMYy0t93Qf
 766A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401159; x=1790005959;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wVlvxm/so69i9rBF3Qqf6pqpvc/+LeTsxiPPuQMtYXE=;
 b=qZk7hvcX+f0W6CXzUsHltxPHCF/+5Cgc2oS3JaPDRbXjeG21y9pOxadpyMq//HrcLc
 Jif8yPaYHgY/oXL5KXpLsG1VifJXo5860C2oyuD0pnsvfRPI+XoHN2e9/PwtyPBHvihx
 Avp3T//5uOhgwHJp8blYqERN13/TabbMXWZn/GCJ/T+7NomJ6vZsm5P2KNODl6PAqqUR
 Nrxx6OUIorr2qEwDU6QmcekivY6YZtigBvcSHUZdeeZWzCj30d+nHWZj1ekmBxx1J/PV
 DWTpby621PE+xaUK5m+fHfEWWrc8bHgT/eXkUfCjOQJ8gU+3NIs5JzRRCFpTuqXPmlTP
 MRig==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZSmUEfuzxDh0eaaY5/+9df+54VC8oj1Hl2YZ2rowof8g58f83f0w0iiFsieVE3a3KB63mrV9H7uA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lNkHhuLynvT2O9384glzcS/DjmC0vza3QAWgw0OHVIQavdWkWE
 67QeuuCOqooUzHWH7mThcCgZFr0+KlwhYKXe9B/wOQHbNPjahXyc2sfypghmwtDMxwBY/R8WOgD
 r5AOl4NpLy6e5hz2OfTPc+TL8BSmFlxeWIjUGZxmup9klS9ozUmStmmzDG9vn8EtkIo0d+Hs=
X-Gm-Gg: AYBFou1JxKrMxVBuGrD+FWmQ5bNQBDrbVagOrP9AL2vCW7Lo+KdGSZaVrFD0/l7j62e
 0egKDHplNTOkcz2ttI0FEza/YB868VDOU5s57CPttxuwdLDhsGOQcuUIX57jy5eymRip8x/TFZX
 0THLh7U/nJoxw2C+EIVDWS9kykXcRG/zz7ViU9OTgqe4uHwtPKLQKjvJyI8+JgxSUMRoQxppg+L
 prelkqa1rIWvDsI8VGCcfc1H3FOh3OFYThw82wBLwbqv3mbls+FsJniHVU+v3kRihjsqi+IPiuF
 o/OOmsP2BYm0S/R5KjCY+UtbmQ6VDV2OuhTdWT3WIUsO9su1yGbJM8eSFrvweCJ/YoKC68ddbkJ
 pa3z76QKQCNMzO2yo/xA0j1wiBBb/
X-Received: by 2002:a05:6122:32d0:b0:5c9:72ea:141b with SMTP id
 71dfb90a1353d-5c981d701dbmr3781363e0c.6.1789401157298; 
 Mon, 14 Sep 2026 08:52:37 -0700 (PDT)
X-Received: by 2002:a05:6122:32d0:b0:5c9:72ea:141b with SMTP id
 71dfb90a1353d-5c981d701dbmr3780433e0c.6.1789401153186; 
 Mon, 14 Sep 2026 08:52:33 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486f301121asm22926613f8f.0.2026.09.14.08.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 08:52:31 -0700 (PDT)
Message-ID: <3bda35ea-1f45-4cc1-af1e-7f1513651b60@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 17:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] dt-bindings: net: Use consistent indentation in
 the example
To: netdev-bot+sashiko@kernel.org
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, justin.chen@broadcom.com,
 florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ulli.kroll@googlemail.com, linusw@kernel.org,
 clement.leger@bootlin.com, olteanv@gmail.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, hayashi.kunihiko@socionext.com,
 mhiramat@kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com, shayne.chen@mediatek.com,
 sean.wang@mediatek.com, johannes@sipsolutions.net,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 jjohnson@kernel.org, richardcochran@gmail.com, geert+renesas@glider.be,
 magnus.damm@gmail.com, yongxing.mou@oss.qualcomm.com, rfoss@kernel.org,
 abelvesa@kernel.org, vineetha.g.jaya.kumaran@intel.com,
 claudiu.manoil@nxp.com, alexandre.belloni@bootlin.com,
 elder@kernel.org, s-vadapalli@ti.com, rogerq@kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, ath10k@lists.infradead.org
References: <20260913122910.99457-3-krzysztof.kozlowski@oss.qualcomm.com>
 <178939022208.22033.14553895731937911806@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <178939022208.22033.14553895731937911806@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa81848 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=JYzT5DUXXbXYkYiThRIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: _4W0A2NOs1QAIWYXGp4DbIMs3KNAIceE
X-Proofpoint-ORIG-GUID: _4W0A2NOs1QAIWYXGp4DbIMs3KNAIceE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfX3yUJMxENUAoR
 MAybOCmjopTq6XVX95eUXpSvOG6aZGySQrU9Y1fX+TQWYEZSm4+ic3U529w39c+lBk4WqF3BpoY
 4cfDFxiw6UnA2zz6434plg1s4Mkc3hf7xfsXkBmuCNxVVsMZiScyMw+XM3nSakvzZg2iO/502ot
 X8wcz0FoyG9mOJFG2jwf5z2iQ/Q4Bx1fHjzeIP0qXbvUmEa/tfLCqBZAjOgzJPFxod94CGX3Mrx
 fgzL4Qb8z17q0ZGaskJ9s7/wYFrCcWiDV03wGgOw5TvyUIhQ18Ao2kcJAKjEwWFDJP1MLjgw743
 X3H6+jINhSFieLY46a948HrOwVVZcivXvCjjNBC9+oQF4gqnDpK+aO2bms8cQFY5cRWsDfIgWhc
 unpnaB6SINDKZBqX11x5v4f7wQLtxZidrCI+x8Jm5lc0fiq9epoW/8pCcI5tPRmqUvfyCEKT9sp
 EDokgx2S5CgFgl/jNnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyNiBTYWx0ZWRfXwaYwN8O7d/ja
 YwOqXaPzAs5blHG4LfQPGkuyfbCyt+Gs70BrP1K/k16Ppg9UIqLKQIUz0Hz0LtDzqMfrz2PwvZR
 bDB3sPl8EL7TSXpmFcZ/sNNQFJJC1Kw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140226
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

On 14/09/2026 14:50, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] In Documentation/devicetree/bindings/net/cortina,gemini-
>   ethernet.yaml the patch does more than re-indent: it deletes the whole…

Overly long, it's like use the most words to explain something to waste
other people time... I really dislike this approach but did complain and
people disagreed.

Best regards,
Krzysztof
