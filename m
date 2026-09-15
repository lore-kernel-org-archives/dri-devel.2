Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A54C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:07:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875C310E0F3;
	Tue, 15 Sep 2026 15:07:35 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAD810E0F3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:07:33 +0000 (UTC)
X-QQ-mid: zesmtpsz6t1789484670t67a17d3f
X-QQ-Originating-IP: VtDu49u5oeW10uTnOj34xIDXGh1ZJrJR14GaSySw/yc=
Received: from [127.0.0.1] ( [180.159.160.209])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 15 Sep 2026 23:04:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3756391934278307056
EX-QQ-RecipientCnt: 29
Message-ID: <811E4CAAE0EC3103+2a53ade9-4b52-49a5-945d-2364fbce3c82@radxa.com>
Date: Tue, 15 Sep 2026 23:04:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] PCI: of: Avoid config reads for disabled bridge nodes
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-1-7de0b6a73d08@radxa.com>
 <xfwoa4jjigdx46lunasf5ze23ihm6qcvbhge7n27mxst5fxyzj@3ovbxzp4wzkk>
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <xfwoa4jjigdx46lunasf5ze23ihm6qcvbhge7n27mxst5fxyzj@3ovbxzp4wzkk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MgRO26CFjEybZlJVhxv+F6oTGh6RwEw9a9Yr08/wwObhmQKJSNI8H8Ed
 emIjA6ZBXgUHKO2GJ+bmUXd2zIzim6nwffUAlZ0eq0CxvE3E3LFueGxSSLNCQ2lFQJxsoy1
 Vfh6ARSKbWwxYgr7mh9Tze3b+wNEsvUXLZTcfXYl1okm7cTuzEbKM5jjUeexs+mTfmTQJrK
 YuYB2eqmMS/AeO3DLo+x/oMLHFvrXl2aFvRpGlFzzuq3A1roKVC3KIZNS7ORYYip+CBDqvH
 fN2pvEPP6bSLqww1tDsNmwRnEcgkxzqyr57lywT3nawrWme0UURgaMwcUADWfJyRE/oprYT
 xmKm/ckzepQkwUE9jJWQr9UdHVfyrfvmmgT7kVLc4YZnGs6mUDPniDZIOHjlRL1k4sEUKZa
 NNY1pCUO1ye7jjA+7MqzNywT5kc/breoGDpSqKprfdj0bIKNybqb7jA1Zsu3tyFlGi8uIff
 Zc4Q0ta9e6yVUKlkUwX21IfNMfR+5elpwqeBS1bQToyhKsmm85Q7a5iLfulPHRrfQrxLkF6
 dwPmu9KUUOkpfHgbY8l/qBKYBgC3dg54SDGu5ghzRlxrDmfhCCKH6r0YTwejyRvheKeS0S2
 b+eyQb9FLi7F59naIrtwrQZsZxrzVeHD56KhTRBX5JToNq/sPjjO4tvcEs06QtqCsdgMY+R
 TOGQKjcvTihRfuYuLf38tdvSbV2mvvqlMQPykZC1uCLrOTqgC0OG/ZmYIkRnO69hGfxp5jS
 WveqivrgG/bwxM3TpqWG0nGLOuRtoiS70P53X8D0sBuEqlTPwe8RWGMzaSnLmQyMf+YYloi
 JOP07Uk8MVhAWNTI9jgdfqxZLYrCLIjZMC/kh8nEfCxZOc5hx74yxHtgdgZpu2EMpNf0Hk1
 FlnCZkk4sU83ydrQaGEvCpITfTrDYVhhG6FkBIj44S6Xxgrbc7D5ziFBasdKZgrj1ycj/Zz
 IeEK3la1XcY5pHQ2IXFsD8Rh3GKmERiIPp1G8yAf/usmXM+Xyb9MXHcu938G+U08Ncj+9pz
 42SwIsOlp8Dhzcv56hcOSfsoSq+AON67u3etr/0eXFNAX62Yq2WeYD4kPpjaiBfKurYpXZi
 FUhawLu6B0v
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

On 9/10/2026 11:04 PM, Manivannan Sadhasivam wrote:
> On Tue, Sep 01, 2026 at 04:47:54PM +0800, Xilin Wu wrote:
>> The TC9563 PCI power-control driver powers off external downstream ports
>> whose device tree nodes have status = "disabled".
>>
>> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
>> powered-off port functions during PCI enumeration raises an Arm SError
>> instead of returning an all-ones PCI error response. This prevents the
>> board from completing boot.
>>
>> Commit 1a8c251cff20 ("PCI: move OF status = "disabled" detection to
>> dev->match_driver") made disabled PCI functions remain discoverable so
>> PCI fixups can still be applied, while suppressing driver binding later.
>> Preserve that behavior for endpoint functions.
>>
>> For an unavailable node describing a PCI-to-PCI bridge, however, the
>> node also represents a subordinate bus that must not be enumerated.
>> Check the device tree node before reading the Vendor ID and return a PCI
>> error response without accessing config space when such a bridge is
>> disabled.
>>
>> Functions not described by device tree and disabled endpoint functions
>> remain discoverable.
>>
>> Signed-off-by: Xilin Wu <sophon@radxa.com>
> 
> Does this patch help?
> https://lore.kernel.org/linux-pci/20260819-ecam_blocker-v2-1-e7a8fdc1c5cb@oss.qualcomm.com/
> 
> - Mani
> 

Thanks for the pointer. I don't think it helps in this case. That patch 
enables the Qualcomm ECAM blocker when the Root Port link goes down. 
Here, the link between the Root Port and the TC9563 remains up; only 
some TC9563 downstream port functions are powered off, and probing those 
functions triggers the SError. Therefore, we still need to avoid these 
config-space reads.

-- 
Best regards,
Xilin Wu <sophon@radxa.com>
