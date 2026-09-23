Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812BAC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC77010EFBE;
	Wed, 23 Sep 2026 10:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IUfuHBdd";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA5F10EFB1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:48:24 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a6063d7dc4so977760a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790160502; x=1790765302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZdJeS2NWmvwKi1c64k6v6zLwI+NJ1nsn1DFESP4VK7w=;
 b=IUfuHBdd5ZxYJbXHdMtWZ8iGtktvl+QXG5tu82QEM0ZG/cYhfL8nNIPEpcqJN8YpKM
 ad7dmEXVQijwEE8BT9bMiV7fbNQnAjuvu7ot1pGUAciYmFY7An4dpn3zH5TuJBsQPRkj
 E25OnlTpuFXWjXUOCBChnjscQfoup6mBmZDiAdOYhvmnGtu8MjXfl5c8S7ViQB0so0UO
 816y17H/ANVooqpTos9Kloj87SHo+jwPLQpMQEHk1v33GdpWxckbaBj9gQ4La7GdZbjw
 02b68kC4XHOolDuXTqUsh+jiBzg1vr4Mq2yAhhScEJ58o1aifdmsn7iZx6VfdmvlVqIz
 uPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790160502; x=1790765302;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZdJeS2NWmvwKi1c64k6v6zLwI+NJ1nsn1DFESP4VK7w=;
 b=KBYoi76qBY0ZVGYB8NJiK1ll/cZCdXHCz53EA4ChPSlFL7iZG1s2QEKGJfzPJtjSOX
 loEzrOiz7QgdCp2gtRUmqdKyVDCjlwpAUQTbu6y4I5ylh+0Rscmv3waqkx4a6PLACrFB
 5JYeJG34GXp/VNQX9eXiG9StMJJB9pjjUzAAlic/xY4lNBEkiVtWPntBT92fWio7tIDo
 swbAm2MUPBVdJJaFUr3H282H0D0z51USv3paiosxqAgMz8kk/t4JAFQ5Yn1gYXy1fgcv
 hdA5L9YonsWWbqmuTzeLndbKn5S0yALab4xeRU+Fhd3xI9VFV8j1M7ElGtdmLnUN5o1S
 Fvug==
X-Forwarded-Encrypted: i=1;
 AKwUvByf2dnQ8+WhU9+ja545TG+t3XJ80hh3A99GiOLJ3K+dPaZVN7kjx2ab70kAI+7GyVSav4JYpy/i5tc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kRmDyFWN6M7Uw6UFJODcctJVcIKhKwSJjUNcSSxBt/rr2eaV3n
 wBDBkUKG8WjnIoKQkdqK52+pCHd/3Cfq1Wc/LzI6pJacE7LR5BolMDfu7P46f5ZpZio=
X-Gm-Gg: AYBFou2ohMBerc2yKqsbao0mffnx08PmB4w9yBeNIVcklAoDq2ARPOn6pSDd0ZLLpxG
 NlEWo7Ts55w/yOpxDpL34kLzNOczeiF2EPbD4w8+XD6lLbKk9JnqeN0wzgslaQt7ybon0eLGpM1
 VgQH30DEGxR5xYIqy8OD2+WlP3fvLP7zk26wbYRhmpok4srPexwT49OMXLph+V952OVesB5QB9f
 kwTlw4sF2m8zWcwVpNcCJZu6cD0TsAJzYzUKilInVaat9t3VSky1cy1WlsPNuZYJz4ZzVuVrhoX
 ZGK1+VHrZKhg6K9zU0PCycdweGfDpGtnbgTcpaKAvVVSAkeA0trT3VYF38rnntIoc5NqK6mp2XZ
 eUjXkmd9HgxyaCW+g3EMTfbPogwsKvhXSDQLuAQqHGi52/PqkX1lqQsnkZw0mHzvdDfUU+91Cam
 9jGQ8EpNt38B5arDSXAljF3oY3oKsf7pb6k5z98wa8CsrZY/768RHwLQfjAvSDNxDvdH885AUTq
 jwqrJjuGZfnacQiKvx65FwxuiCm4Z83Mult3Kp+PwnOEJSmIa5zTQ==
X-Received: by 2002:a05:6402:52c5:b0:6a9:d0f0:69a0 with SMTP id
 4fb4d7f45d1cf-6aab3b0a3e2mr1757911a12.11.1790160502330; 
 Wed, 23 Sep 2026 03:48:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:4140:d290:ef49:44ba?
 ([2a01:e0a:106d:1080:4140:d290:ef49:44ba])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868266822sm6706162f8f.5.2026.09.23.03.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 03:48:21 -0700 (PDT)
Message-ID: <f77e53d3-fb80-4832-aff7-4ab1244ee4a4@linaro.org>
Date: Wed, 23 Sep 2026 12:48:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [REGRESSION] Resolutions broken after "drm/msm: dsi: fix PLL init
 in bonded mode"
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Mohit Dsor <mohit.dsor@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
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
In-Reply-To: <d7v4kwmc42k5ymgdt4mn2qc7dkrf5jj2l5afgyjqrm3pxterl4@guulk22xwlzs>
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

Hi,

On 7/8/26 15:31, Dmitry Baryshkov wrote:
> On Wed, Jul 08, 2026 at 09:26:04AM +0200, Thorsten Leemhuis wrote:
>> On 7/6/26 11:52, Mohit Dsor wrote:
>>> On Wed, Jun 03, 2026 at 03:11:34PM +0300, Dmitry Baryshkov wrote:
>>>> On Wed, Jun 03, 2026 at 11:56:15AM +0200, Thorsten Leemhuis wrote:
>>>>> On 5/4/26 22:09, Mohit Dsor wrote:
>>>>>> Sorry for the late reply. I am attaching clk_summary and reg_dump in
>>>>>> working and non working case. Lilliput is just a normal display working
>>>>>> with hdmi and has 720p as preferred mode. Yes, I was talking about RB3
>>>>>> Gen2 only.
>>>>>
>>>>> Neil, Dmitry, and Mohit: what's the status here? From the outside it
>>>>> looks like this regression is still unfixed with nothing happening for
>>>>> weeks now. Or has progress been made and I just missed it?
>>>>
>>>> Thanks as a reminder. Unfortunately, it takes some more time (and I've
>>>> been a bit overloaded lately). Worst case I will send a revert soon.
>>>>
>>> Just wanted to check if you had a chance to look into this issue and whether there's any update on the investigation from your side.
>> Hmm, no reply. Given that we are entering holiday season and are way
>> past what Linus expects in a situation like this[1] I'd say we should go
>> for a revert, unless some fix shows up really soon now.

Sorry I'm very late to the party, and checked again, reverting this breaks all dual-DSI setup
on SM8650, and probably other similar SoCs.

Here's a complete log of the breakage which appears on the Ayaneo PS2 running v7.3-rc3 with mainline panel driver: https://gitlab.postmarketos.org/-/snippets/65

I don't see why my fix did break this use case since it reverted the way the dual DSI PHYs
were initialized to actually allow the dual-DSI setup.

Thanks,
Neil

>>
>> Ciao, Thorsten
> 
> Please send a revert.
> 
>>
>> [1] To quote Linus statements from
>> https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed
>>
>> """
>>  From 2026-01-22:
>>
>>   But a user complaining should basically result in an immediate fix -
>>   possibly a "revert and rethink".
>>
>> With a later clarification on 2026-01-28:
>>
>>   It's also worth noting that "immediate" obviously doesn't mean "right
>>   this *second* when the problem has been reported".
>>
>>   But if it's a regression with a known commit that caused it, I think
>>   the rule of thumb should generally be "within a week", preferably
>>   before the next rc.
>> """
> 

