Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B38AC624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 841CF10F5D3;
	Thu,  3 Sep 2026 14:42:44 +0000 (UTC)
X-Greylist: delayed 105048 seconds by postgrey-1.36 at gabe;
 Thu, 03 Sep 2026 14:42:41 UTC
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891BE10F5D3
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 14:42:41 +0000 (UTC)
X-QQ-mid: esmtpsz19t1788446514tc68bbb6b
X-QQ-Originating-IP: MeASNOdmrs56CZbnO7tzXMJwu+SSeXXkrojO4rHMzek=
Received: from [127.0.0.1] ( [180.159.160.209])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 03 Sep 2026 22:41:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15928767512073922891
EX-QQ-RecipientCnt: 29
Message-ID: <1437AFFE6B2A54BD+7fe7c715-a19c-4efa-bf66-50b5c04ffb19@radxa.com>
Date: Thu, 3 Sep 2026 22:41:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
 <8c2eaba0-c1bd-4db0-bbc8-5ae3b3d9a13c@oss.qualcomm.com>
 <B4EB99E5B76C9F40+e6fdbdd4-5c05-4b98-867c-29c7178a0d72@radxa.com>
 <a5d83aa4-7065-47c0-bbda-35063034b0d6@oss.qualcomm.com>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <a5d83aa4-7065-47c0-bbda-35063034b0d6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OGRTx1KypL8C0MPdYFDfRXngEb9R45x+ZcfuMshYmcbpQKQ5nsTICWn3
 FqcUKqHK/yq1QllReLC7mUgRfB3RbW4r71lb+ASBsB2S1c6XepeP3m6m6AotobmrXQpDV94
 JoB3CvKbkmUJV6pQhRyKCfokH2bx0JHAjsWFdGZzxT4gD+jSzTFlqY0lqc2oOTzYWUszkeZ
 h38UwYsXoHjUAGHh7JekPTBGSFBRCH0r82zdNzN/xaV7YyAq3TPamq4sq+uM3MRKCjW05TV
 7njzM7cmdI4bkPNTgVz1GohQL01iueNJ1Yqaj3m4U2vhQve/MLV186cSCxa9Is1/iET5a9r
 Mmn95ITiBmoQHEP02gw/0U0yMmMRPcHfvlRLuNhNW1z+jycwT5hWi3x6InUbNVCGJ0tU/Bf
 YIPpp5ozFU7dAgVKPgh8SsbQbr18OFLOhfgmzj4fXvMiGFsaUsdDLFuBLidkA5OXR3EA+Ba
 zaMldZbiUP+wR9WSayxKNXwE4K0VjdOiiR5Hr0ZFHJLAs9ROI09V5jA0vIgPysbSaZXG/wT
 g+Zo/Guthqzs4QZ2miFzDsxK0zCr1IxLb/wPyeUQjSqeQWSFNQ9EjRLDQs2lZCn8vgxI9pB
 HA1pq1yd+uwoaf08n1A3KveOefJ7tvuY/6GCkKULCCkF8neiIObqRzpDK0IFiSLieYRbZLt
 aRPqLIYf3cviF/hyVkOjrylUTXqkdsC3FE5SuI+4orNNGNZtYOBNzpLJ468E+SrtLYuSqcH
 MWbd+LStx5Edk8bLxDgr9+7jFA9LnTKR4ZsLkqz7CBpGotfV0Heds5hRNnu1N2R1XM9yJUq
 lD8crLgYdzGa34VDoSLTLrQFoqDU1UXKYv9QDo1TlB8k9oqlEjRPDiPyd0cktiU1iaWWDDl
 DVMbYtt2y1RDUzonOLFz962qD5Jq4zVQ3anDDnr52ffbRugJOftyUm6Sl/1FxaNeZDa2NuL
 AKzD6T7lbzeFmS9NQeXXQCwTYff/SSSM6AAntMA0sH18k6Fdvbxuzyxdw+Dhj675CzuG+0s
 Jb+zog2ojVxMDC6Q3hDlS6yCwOfhAPYWV0u0+DaQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
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
Reply-To: sophon@radxa.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 9/3/2026 10:40 PM, Konrad Dybcio wrote:
> On 9/2/26 11:31 AM, Xilin Wu wrote:
>> On 9/2/2026 4:43 PM, Konrad Dybcio wrote:
>>> On 9/1/26 10:47 AM, Xilin Wu wrote:
>>>> The TC9563 PCI power-control driver powers off external downstream ports
>>>> whose device tree nodes have status = "disabled".
>>>>
>>>> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
>>>> powered-off port functions during PCI enumeration raises an Arm SError
>>>> instead of returning an all-ones PCI error response. This prevents the
>>>> board from completing boot.
>>>
>>> I agree with the premise of the patch, but I'd like to understand why
>>> that happens - do you have any details?
>>
>> Unfortunately, I don't have further details. The downstream kernel also includes a similar workaround, so I suspect it's related to how the TC9563 chip is designed.
> 
> I'm curious in why the port is still advertised on the bus if
> the i2c interface writes some magic bits to "disable" it on the IC
> side.. but perhaps that's just how that IC behaves and we can't
> do anything about it?

Yeah I think so.

> 
> Konrad
> 


-- 
Best regards,
Xilin Wu <sophon@radxa.com>

