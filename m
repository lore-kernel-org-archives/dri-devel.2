Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD419C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E428610F341;
	Thu, 24 Sep 2026 07:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XFTg7Fc/";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF23810E07F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:09:42 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48870973bddso250891f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790233781; x=1790838581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7avs/biYs8l8E4Q+bkJinfYIswxmGt6u/gkPhCnUaNY=;
 b=XFTg7Fc/6S1JU5S92TSjEc2IpPNoiI+GzOdjFs6Nc7NrB6HZmQjHY7l0Tdcpw2Ktmy
 ZcUxFeTZH8jxMj3HmT36vdzN8Ky5sj4nxlNoZMUNjRDpoZmCM6l2cIxZteIWhuu+Uwmh
 gv/9dfuMBIWhgmTZSDwLRfh4rAqifEv00MAo093m5trjg9+3WIgK4xfeV7T/llPzEcSE
 K3+5yFaUX3xHF21caFiEZogrvosiNnrit9drNnG9vd1xlRdHpSw+xjSxRWQt3TXeUwyn
 9F6OnvlLqUdl+xpUYIfOSwV9vi4ukXIiyz/1Nuo3EMfon21blE5ni9ZlhXypg23qDq+r
 E3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790233781; x=1790838581;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7avs/biYs8l8E4Q+bkJinfYIswxmGt6u/gkPhCnUaNY=;
 b=o7UvQJZ1rSiPEpuIT/FGlU6J/bXO+TGmFLuFUbR6F0Dz5guuA7MHrHq0/wsYp+9XMW
 RnXliSGH0yfZGiw+zLftybvr6qEHBi0Sk+tXVKwmTmgNE1h6EL53rGUVYwKUWb6HggCj
 RvuFcQCePfw2WssXky02132TLpuH+EcjbRba89UMXiNAU0e010cYAE7hUkf3Obn7Endv
 4+vGpL/eepezlf2HC2zWP0O81Uw8E9Tb/A55HOkXUZ4Kh0D3CTfW0tyDVNdhZTimUxTJ
 ww+fi3OH0kORRYSA7rHA6SEz0/C1l3gVWRMcB16qbeOxnSi77vCc7rdw+8i4X3+jQ/D/
 4SjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0/EHQcSCApqZJypsRcc7GXld//5WnXMhbNLa62w6fqIw5ffqEygtd6EWLkcBmVbWekng+6SkR6xQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nDF3gmUYN6+oZOMsAbSQJckr/gFQC+ok8PwB5um2jc+7OYCODF
 ND4geexFURszsMGm2rBM4BMLsvJYlBslLk6bGRJwC2Q7cvRDvPkXbcudMglp8oL7hRs=
X-Gm-Gg: AYBFou2Qt5srKsx6ff4gdfiGsbBs+uo2wIbMQKvhaFQIvtuXz9XcV/g0CoyZQKEBD/i
 Avy5DEz+oR2cvodHvfkIMgrDcghFPh5cVmhRVuJq2dCOtdwFZlq5kdUqzkMoqA5ggS+h9bwOlgh
 7TA1BNdY7FVhKiARtqAlrfkUR2pdbqD30EzKbEckn04KzK5PfPExzRUF6T1QtY6HuosQzdFx7Gt
 GQpv3PVo2lbwy0V2Yg5atjT8fqpBmRDIteuOoaQQUv+vhGfe0oebXHns/vPrEer1r7ZoRhE7Hx7
 S6lcwySC9G5bxLTlpaPNitgZAYxBwe4pcgbpiZbS1gCF6FThzBwVi2GMD/zmEEIs7I5xsp/j+6G
 mFkwrNw07F0F6JTkKgaZjBhiiAj3O83coiTWgaCOmlgX1Wdz5MNdV/Uq66rxFVI3AxmXdJzY097
 WMnCEE2hTyK31m56NQtbmJ4lRDMQAZ25rHgoCrO45znlb6LTOp57kq2ZQ/TvKwN9kgZTqOqh84K
 KMbx/ZYwYqMDa/SomRo+dS84Jf9au1w8ghzhvCKEsm9dc4TOFVeShBD297rQOl30wE/frC37a0=
X-Received: by 2002:a05:6000:1861:b0:487:e:f4f6 with SMTP id
 ffacd0b85a97d-488716dd323mr2953334f8f.15.1790233780913; 
 Thu, 24 Sep 2026 00:09:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5e86:d153:fdb4:61c0?
 ([2a01:e0a:106d:1080:5e86:d153:fdb4:61c0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a2a5sm13347227f8f.26.2026.09.24.00.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 00:09:40 -0700 (PDT)
Message-ID: <2e369f45-6c9a-4604-a66e-f35c0904ec0f@linaro.org>
Date: Thu, 24 Sep 2026 09:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [REGRESSION] Resolutions broken after "drm/msm: dsi: fix PLL init
 in bonded mode"
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Mohit Dsor <mohit.dsor@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, vishnu.saini@qualcomm.oss.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
 <ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com>
 <wrhuksrzlxw2pjlvjm37dwjuztcv7qs5t6mqiav4ujecwqdkwj@ozbfxpbgaimt>
 <CAJfMnmEVwUwt=wMJ-8HKH1yz9+erWLrRGB+6wVYCdSGDK+_T_Q@mail.gmail.com>
 <114b9be8-1fca-4762-822e-1d53838d5de5@leemhuis.info>
 <o64cxeq5f4ffqpdmbai5cvsmxei2cnw3p6acvu55xl3cj5w3z3@6o6kokszvng7>
 <akt6z1irWlXA5UIy@hu-mdsor-hyd.qualcomm.com>
 <493b8d4c-164e-43c9-93c8-40cc251b1c3b@leemhuis.info>
 <d7v4kwmc42k5ymgdt4mn2qc7dkrf5jj2l5afgyjqrm3pxterl4@guulk22xwlzs>
 <f77e53d3-fb80-4832-aff7-4ab1244ee4a4@linaro.org>
 <y64m2frbbg67zfukyuuds5cx65fx3rjxfujbckoerv7sswhk2u@i6p4k3ul4aec>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <y64m2frbbg67zfukyuuds5cx65fx3rjxfujbckoerv7sswhk2u@i6p4k3ul4aec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 9/23/26 22:58, Dmitry Baryshkov wrote:
> On Wed, Sep 23, 2026 at 12:48:21PM +0200, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 7/8/26 15:31, Dmitry Baryshkov wrote:
>>> On Wed, Jul 08, 2026 at 09:26:04AM +0200, Thorsten Leemhuis wrote:
>>>> On 7/6/26 11:52, Mohit Dsor wrote:
>>>>> On Wed, Jun 03, 2026 at 03:11:34PM +0300, Dmitry Baryshkov wrote:
>>>>>> On Wed, Jun 03, 2026 at 11:56:15AM +0200, Thorsten Leemhuis wrote:
>>>>>>> On 5/4/26 22:09, Mohit Dsor wrote:
>>>>>>>> Sorry for the late reply. I am attaching clk_summary and reg_dump in
>>>>>>>> working and non working case. Lilliput is just a normal display working
>>>>>>>> with hdmi and has 720p as preferred mode. Yes, I was talking about RB3
>>>>>>>> Gen2 only.
>>>>>>>
>>>>>>> Neil, Dmitry, and Mohit: what's the status here? From the outside it
>>>>>>> looks like this regression is still unfixed with nothing happening for
>>>>>>> weeks now. Or has progress been made and I just missed it?
>>>>>>
>>>>>> Thanks as a reminder. Unfortunately, it takes some more time (and I've
>>>>>> been a bit overloaded lately). Worst case I will send a revert soon.
>>>>>>
>>>>> Just wanted to check if you had a chance to look into this issue and whether there's any update on the investigation from your side.
>>>> Hmm, no reply. Given that we are entering holiday season and are way
>>>> past what Linus expects in a situation like this[1] I'd say we should go
>>>> for a revert, unless some fix shows up really soon now.
>>
>> Sorry I'm very late to the party, and checked again, reverting this breaks all dual-DSI setup
>> on SM8650, and probably other similar SoCs.
>>
>> Here's a complete log of the breakage which appears on the Ayaneo PS2 running v7.3-rc3 with mainline panel driver: https://gitlab.postmarketos.org/-/snippets/65
>>
>> I don't see why my fix did break this use case since it reverted the way the dual DSI PHYs
>> were initialized to actually allow the dual-DSI setup.
> 
> See commit cb55f39bf7b1. Without PLL_SHUTDOWNB and DIGTOP_PWRDN_B most
> of the PLL registers read as zero. Currently the regs are handled
> correctly (almost). With your patch in place the SHUTDOWNB gets dropped,
> making PLL loose reg contents (and return 0 to CCF as the selected divisor).
> Current code depends on those two bits being set across host_power_on.

Thanks I'll have a look.

Neil

> 
>>
>> Thanks,
>> Neil
>>
>>>>
>>>> Ciao, Thorsten
>>>
>>> Please send a revert.
>>>
>>>>
>>>> [1] To quote Linus statements from
>>>> https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed
>>>>
>>>> """
>>>>   From 2026-01-22:
>>>>
>>>>    But a user complaining should basically result in an immediate fix -
>>>>    possibly a "revert and rethink".
>>>>
>>>> With a later clarification on 2026-01-28:
>>>>
>>>>    It's also worth noting that "immediate" obviously doesn't mean "right
>>>>    this *second* when the problem has been reported".
>>>>
>>>>    But if it's a regression with a known commit that caused it, I think
>>>>    the rule of thumb should generally be "within a week", preferably
>>>>    before the next rc.
>>>> """
>>>
>>
> 

