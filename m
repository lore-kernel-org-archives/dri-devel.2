Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95225C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039AB10E56C;
	Wed, 29 Jul 2026 09:17:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FvFPi8rL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0974A10E56C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 09:17:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 497B341438;
 Wed, 29 Jul 2026 09:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E161F000E9;
 Wed, 29 Jul 2026 09:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785316628;
 bh=eVJxQEzXpQWTkC0PquYQGc64UxulzBTi6LZYawBPiGU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FvFPi8rLszzW2JvBTxLJOwLbPhEP70GBYLPnpq4gvBp9sQ4l8b6CbQql0lKzn3jU8
 O9OXXRBtHw8AH4JdcjfKimSMRpmEttJSsZwbpw3UrEvkbUgLQQcPnnS0m/IpK8OT9k
 B8RC+LnKcQgGbSDRO/vOysLCNk6eXNl6bNJgxfV4oJXYwYaJMkgHBOOCOmn+6mRma5
 lCCD2mPlhlGYRWukQaN6ZqqoRThFq3jZULJmbS4en621R564PKvVzJqa/jEJFWyy0b
 pzbT56zNMy3edqS2XmGZiuv5+M4iKahrMsso09q92YRHFLU9QZLJvjXluZYwdwlXw6
 04911Xqp1BYqQ==
Message-ID: <39f12852-a0d4-4d90-8ea3-dbfa7e1c2059@kernel.org>
Date: Wed, 29 Jul 2026 11:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: gpu: img,powervr-rogue: add
 spacemit,k3-gpu
To: Baihui Liang <liangbaihui@linux.spacemit.com>
Cc: "frank.binns" <frank.binns@imgtec.com>, robh <robh@kernel.org>,
 krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
 dlan <dlan@kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 spacemit <spacemit@lists.linux.dev>
References: <tencent_79CE08BE248E9ACA2E62BF64@qq.com>
 <065a229b-e6a8-4cce-8725-9c2e19c8f463@kernel.org>
 <DKAXV3CTQ6B1.36715CJUMEB9A@linux.spacemit.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <DKAXV3CTQ6B1.36715CJUMEB9A@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 29/07/2026 11:14, Baihui Liang wrote:
> On Wed Jul 29, 2026 at 3:57 PM CST, Krzysztof Kozlowski wrote:
>> On 29/07/2026 09:46, Baihui Liang wrote:
>>> On Tue, Jul 28, 2026, Krzysztof Kozlowski wrote:
>>> &gt; &gt; [...]
>>> &gt; &gt; spacemit,k3-gpu is added to the existing ti,am62-gpu/ti,am62p-gpu/
>>> &gt; &gt; ti,j721s2-gpu "if" block that restricts clocks to a single entry,
>>> &gt; &gt; since K3 has the same single-clock requirement. It does not match any
>>> &gt; &gt; "if" block that constrains power-domains, so that property falls back
>>> &gt;
>>> &gt; I don't get this explanation. Are you explaining what the patch is doing
>>> &gt; or explaining WHY you did this that way?
>>>
>>>
>>> That paragraph was describing schema mechanics, which does not belong in
>>> a commit message. v4 will drop it and state only the hardware facts: the
>>> K3 integration of the BXM-4-64 has a single "core" clock, and it has no
>>> software-controllable GPU power domain.
>>>
>>>
>>> &gt; &gt; to this schema's general constraints, where it is optional. This
>>> &gt; &gt; leaves room for a power-domains provider to be added later without a
>>> &gt; &gt; further binding change, should one ever be modelled in Linux for this
>>> &gt; &gt; SoC.
>>> &gt;
>>> &gt; No, you need to provide constraints now. Please read carefully
>>> &gt; writing-bindings.
>>>
>>>
>>> Understood. spacemit,k3-gpu currently matches no power-domains "if"
>>> block, so it falls back to the top-level 1-2 domains with
>>> power-domain-names "a"/"b". That would let a K3 DT with two power
>>> domains pass validation, which does not describe this hardware. v4 will
>>> add an explicit "if" block:
>>>
>>>
>>> &nbsp; &nbsp; - if:
>>> &nbsp; &nbsp; &nbsp; &nbsp; properties:
>>> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; compatible:
>>> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; contains:
>>> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const: spacemit,k3-gpu
>>> &nbsp; &nbsp; &nbsp; then:
>>> &nbsp; &nbsp; &nbsp; &nbsp; properties:
>>> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; power-domains: false
>>> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; power-domain-names: false
>>
>> I understand only half of this. Please fix your email client.
>>
>> And why this reply misses reply-to header which connects it to proper
>> thread? How am I supposed to find the thread now, among 200 I received
>> yesterday?
> 
> Sorry -- that went out through a webmail client which sent HTML, so the
> quoting and the YAML indentation were destroyed, and it composed a new
> message instead of replying in place, which is why it lost the thread.
> I have switched to git send-email over our own SMTP; this reply should
> be plain text and properly threaded.
> 
>> So your name is presented here as "Baihui Liang" then why do you use
>> some fake company name?
> 
> liangbaihui@linux.spacemit.com is my real work address at SpacemiT. It is
> now sent through the company's own mail server.

Again: then why do you use fake company name as name? Actually not a
company name, but laminated product of some company?

What is Sterling-Ash?

Best regards,
Krzysztof
