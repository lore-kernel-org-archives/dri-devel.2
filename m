Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A9606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASSC1kCK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EB9C10E0E5;
	Wed, 28 Oct 2026 14:57:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD19010FD13
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 14:56:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9169B43BE2;
 Wed, 28 Oct 2026 14:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA72F1F031E4;
 Wed, 28 Oct 2026 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793199415;
 bh=F7boTTUOUIPt+1we1rY2+5xkr9Y/R4tCTMv/ZzlovJc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ASSC1kCK23aEi5cQdP9zLIFHwlOVpSVfqVCZCjJrl0CQgE0+bsRSpLQ7CcH8l428j
 dZcelsEzcj0x/I09wMUUVdLDW1ismeo2j3D09oNo3rKpB46DOK51FFwK8pPNjTrPD6
 rBWyDEO51PIGqEWHLbI7VJPRKJ6r+FSWA2KhpbWz4OCvseGw+MCCf74RqgPmvkMlsi
 99FcWsfPvvKoNxL5vozdVcT8/BIeGRnPGczwIpd6jIYRPC0ZdGrbVrbxY+4da4H2nc
 jy91TdMKnYpZbiqGppIQjt4IkjzcLs85MCRYfWZ5VNyW20idYeNt0gma0evv+dCFSW
 Sem7bo/HXD1Jg==
Message-ID: <07c2c10c-f442-480d-b545-666069c06e91@kernel.org>
Date: Wed, 28 Oct 2026 16:56:49 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: display: panel: novatek,nt36672e:
 Document the reset GPIO polarity
To: Krzysztof Kozlowski <krzk@kernel.org>, Vladimir Zapolskiy <vz@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
 linux-arm-msm@vger.kernel.org
References: <20261028095151.1682096-1-vz@kernel.org>
 <20261028095151.1682096-2-vz@kernel.org>
 <20261028-seagull-of-illegal-prestige-6cbbfa@quoll>
From: Vladimir Zapolskiy <vz@kernel.org>
In-Reply-To: <20261028-seagull-of-illegal-prestige-6cbbfa@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 15:56, Krzysztof Kozlowski wrote:
> On Wed, Oct 28, 2026 at 11:51:44AM +0200, Vladimir Zapolskiy wrote:
>> The reset GPIO of NT36672E panels has been described as active high since
>> the binding was added, also see the example and the QCM6490 IDP board
>> device tree, however actually it serves as the active low signal, also
>> panel-common.yaml expects active low reset GPIOs to be described as such.
>>
>> Document the active high description of the reset GPIO explicitly as
>> the exceptional deviation from the actual signal polarity, any new devices
>> will use it in the same way as the existing ones.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
>> ---
>>   .../bindings/display/panel/novatek,nt36672e.yaml         | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
>> index dc4672f3d01d..45743376995b 100644
>> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
>> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
>> @@ -24,7 +24,14 @@ properties:
>>     avdd-supply: true
>>     avee-supply: true
>>     port: true
>> -  reset-gpios: true
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO connected to the reset pin of the panel. The GPIO must be described
>> +      as active high (GPIO_ACTIVE_HIGH), the asserted state releases the panel
> 
> I disagree that it has to be active high, because, since we do not
> represent pin inverters in DT, it depends on board layout. Wording would
> need to be correct if this stays.
> 

I'm all for a better wording.

The described display panel device operates (here resets) according to
the active low signal RESET_N, the device driver is written to interpret
the signal as active high. A signal inverter may be present on a board, but
then the description of this board feature would belong to the board dts,
e.g. in a form of a simple comment around the property.

>> +      from reset. Note that the RESET_N pin is in fact an active low signal,
>> +      the inverted description is kept for compatibility with existing device
>> +      trees, while it deviates from the convention of panel-common.yaml.
> 
> We might fix it at some point, so not sure if it is worth documenting in
> the binding. And what about usage of this binding in other projects
> which implement it correctly?
> 

In the upstream there is only one user qcm6490-idp.dts, and changing
the polarity will be an ABI breaking change, unfortunately.

Here it's a similar story to another one about OV9282 reset-gpios polarity,
it ended up in keeping the polarity of the signal to avoid ABI breakage:

   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/qrb2210-rb1-vision-mezzanine.dtso#n45

Probably the best way to operate here is to give a clear 'reset-gpios'
property description in the OV9282 sensor or this NT36672E panel dt docs.

-- 
Best wishes,
Vladimir
