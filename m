Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AADCC624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC7510EC6B;
	Wed,  2 Sep 2026 09:31:58 +0000 (UTC)
X-Greylist: delayed 88986 seconds by postgrey-1.36 at gabe;
 Wed, 02 Sep 2026 09:31:56 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C6D10EC6B
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 09:31:56 +0000 (UTC)
X-QQ-mid: zesmtpip2t1788341474t02b33272
X-QQ-Originating-IP: DfJlt4hMjpdtOyPap8HbaAi8yVDkdztk3fLVqYXeqbQ=
Received: from [127.0.0.1] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 02 Sep 2026 17:31:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11555312155926092198
EX-QQ-RecipientCnt: 29
Message-ID: <B4EB99E5B76C9F40+e6fdbdd4-5c05-4b98-867c-29c7178a0d72@radxa.com>
Date: Wed, 2 Sep 2026 17:31:10 +0800
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
Content-Language: en-US
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <8c2eaba0-c1bd-4db0-bbc8-5ae3b3d9a13c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MDBUjbbN2l4j6c0MWqqdzz5hh4XosIgVOIX9mJRfFWZ+YOHB/GpvddDJ
 7k+y4Wn0FYOrfuSAcSghzH0ry8XyWn8HtwsAKCcsibLA0amptme561IfePwWObLhjQZFPdw
 fYaPrzIbmCS2jHOLd6FpUBlCTGPjne/Rg0WYK4BWwe4Q+JCECpgreq/QgAS/WLAX7HORRag
 1PZjDAwQRjokrLZETndvKay6PUS8dTMlAqQQil3rhX4B4XlQwAOJr+G5z2SorCreXffpWjr
 UqtcrTngEIc57vAz5eK3GXIrOOYiR3s8COXSxLTnE/xRROKxmRy8nrxYeMuU0v+YiP0rU8t
 PZGmccDWF/PJ0u9ABeE7o8aKAb/UTk0G9ZPaIWsbhgEb6IJlWj7soAeuT19dXj5ax6qaBAN
 YkMhKMmvnYvBXSAdxNRRo+DYrf4BrVuQN+9AIir1ltyPImRBkHwW/68jOw7ba1aGe0xcHLv
 EtDZ5KwDdzpz9QCRvyY6lpxxK36/oghhCSLZAwRSlVfKV10pWvSp1KH4zlcwZkzonzax/To
 ROBj1H/7QDbZOsID4bpXF6bu2u40dbhgeq/kOu4fNlfjtLKpq+tLM8spcTRxZ5Enl+iwB5+
 ROiCnMff7LI/anlclnu4+d1el7gNf3RL+8qBDijE6HnC3NXxG8nASJz5NDEF22XW04UnGu3
 ayzg3ACMK7TbntVEno0e0pif9y6+M/Koybc5c9c/z2BmiDIHhgIYyQWKp/fcJs69BscR7kz
 8qM+MpcgIysxaH8DbXMKsFuo0MRlALIR2+L+pAafwCKJiqJ8OjEU4gddu7dXdGu78/p55sZ
 GhWb4T093poBv0JMgzifYQsv1yGx3aLB+QcZgtQevKPJdTvztOraDWgVE9BghH9qQN+lVbw
 Cf+CdM01eDBR5mTOPH91jrQ/f7b58Azb9vb2Rbk9JRQLrgR9d24O6wuwJBQ7dP/FF3hMB5G
 iwa1FCcZgygldnVJx9FOkqCm/h16C6s3WHiSxjX3RXeHQqwHCmSq7Trk7IgpBrlH7VHL40e
 wLuMrhCPzKY4zVC2RH7ajVCCLkR4826RqCSrewi72VGGsiY2U8Cq7UAJa2/ud9yoxIPqiHb
 iExuJVsv7wt
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

On 9/2/2026 4:43 PM, Konrad Dybcio wrote:
> On 9/1/26 10:47 AM, Xilin Wu wrote:
>> The TC9563 PCI power-control driver powers off external downstream ports
>> whose device tree nodes have status = "disabled".
>>
>> On the Radxa Dragon Q8B, reading the Vendor ID from one of these
>> powered-off port functions during PCI enumeration raises an Arm SError
>> instead of returning an all-ones PCI error response. This prevents the
>> board from completing boot.
> 
> I agree with the premise of the patch, but I'd like to understand why
> that happens - do you have any details?

Unfortunately, I don't have further details. The downstream kernel also 
includes a similar workaround, so I suspect it's related to how the 
TC9563 chip is designed.

> 
> Konrad
> 


-- 
Best regards,
Xilin Wu <sophon@radxa.com>
