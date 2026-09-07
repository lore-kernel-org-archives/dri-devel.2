Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56020C79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D39E10E00B;
	Mon,  7 Sep 2026 16:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UZA8aGUg";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56ED310E00B
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 16:35:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso16061365e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788798926; x=1789403726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AJ38KZrQ1VU0wHJvFYCofD4vSHW03RLbTPeGnMYRlCc=;
 b=UZA8aGUgaXRi2XsnLI+SZATrOfPAf3AJUGsk4lTPAqyohb5lhG4lu68f9y+JysxsRP
 6xF6C6dUvQxgrsbvbnYwVaj52VJDO2eItAfcCVr2EQ9JDbGdkn4k7oXRs3p0n8aXPqMn
 PzeVSqzzwH+5WcPUN8EGzSTsTP9rLRnR0/QVzEFtItEFqLroCv0ebN01TwKAyyABhKVv
 UBo7tgmLO4cysnycX7TM8r+S95Ufe0zxsfhe4lG/Bi6RhMYx5njUom5MdS7iiVNP9IFI
 zOYM10ia2+ZaON1HCplU7y2B7FEpeKTRsyqre6LJ25dwgfuw4lW+KbEI6iL1LltcLPqO
 IORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788798926; x=1789403726;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AJ38KZrQ1VU0wHJvFYCofD4vSHW03RLbTPeGnMYRlCc=;
 b=Q9KJ5NTTi3j2RSmzX224OmptbzSpImw9XfV7Vo4gBYRqAEb/eD2cO4HKV+wK0DbJQX
 vU7b92H5TCDnwj3ySNXml5Vy3vsb8oZG537+ZKW24s0yKJ6o6NOIKtzTSLekpWQbMdBB
 D7euSPW7pFF/4FS8ntGnAAllcgdhvgbq7vaYv9Z5OWxZ552YdlxsJuuJj6GoVKiTeDkW
 mWnagRfXvD4Wx2/DeoaqsQ7+yBO3ZWkWJyBTRY0b0bEO5+s9E2v2qpZuDJkGjz7kFY4i
 GpnHpSr39jjy8oC+aDwC0wJLOpurTHqVJtlXHt0vKOPYwroiw967lNLEYEJPaJ8ZaELQ
 SY9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9xAGnsdULpzanpVPYZC1eDcbG5wCEHRgz7z7JWReaC27l0JQsg2aPhCq8xitUi6UDHYPk+6AR++c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lUjhwPlXz1x+bs37m/n1zgPT2FjkhytKPIcI14qOEJlgmZ0mvb
 hnZfJWJuiZLPbQ00sQRl5YKDbTDkhBadhJFnk+r4gvkrGlcL2GXgzw28V8u1Xmo7loM=
X-Gm-Gg: AYBFou3m3MeLW+eSo60qXwDI8HbpPT2gyY7vwpk7LHdtik3WlGmiZItwqbkWsLHx3CN
 nr+9XBYBGz559GKNwrcfTYOu/48tgiU1Wm4kFAEdztAArpnLvbTtrkifBUERVmv5Xmn7HfPV8W7
 fUWBBRReU14krc5P91xTm9dE6T3MfN+DHT7L4WM1rlI76dZXelma9V9aZ1NZKEjqaTuPDmKx2mz
 boCSj8YrH4CVzRuLMmglpThnC+TlI+mMrgoVFr6jS+hiJMRcDPgvLo8Njx/EeSzClV5mBnXONxh
 EOImYs3OwUfvEqvjXoTVRzRRFVmLdf5jYvMLZ4NKENMCAl/Eo5sg2FoJiX3YefBdEnUg8pdLfAm
 1zI5zzbpjy5zAjnMcqfCqoV7Ruqz2hYEAVKN4r5eADabNQtmlQHMEw9RLKBEHiiXWH7p8vJxJJK
 eKQMB5tCbfZfW8bdBz/auHnewvQ/k3xFlseNXdPWrtSLxtH93Y4coD//gKOWF0/Jb6ODIVUUXZM
 h2ionGOhiohgHX+a81FacvC1erh9PcVaUlMNre6djo=
X-Received: by 2002:a05:600c:530d:b0:49c:fc6e:8cae with SMTP id
 5b1f17b1804b1-49cfc6e8f24mr189817335e9.18.1788798926391; 
 Mon, 07 Sep 2026 09:35:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:74d7:9035:e283:b480?
 ([2a01:e0a:106d:1080:74d7:9035:e283:b480])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm28013294f8f.36.2026.09.07.09.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 09:35:25 -0700 (PDT)
Message-ID: <e1971874-6e06-4ffb-8118-c4acc40144eb@linaro.org>
Date: Mon, 7 Sep 2026 18:35:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: SM8250 USB-C DP alt mode: DP AUX times out in reversed (CC2)
 cable orientation
To: BurningHoryd <sjunhyuk1@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Vinod Koul <vkoul@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20260906225206.2994952-1-sjunhyuk1@gmail.com>
 <f0fc4211-2040-4115-9847-6e5cc3fe8161@linaro.org>
 <20260907162643.36585-1-sjunhyuk1@gmail.com>
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
In-Reply-To: <20260907162643.36585-1-sjunhyuk1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 9/7/26 18:26, BurningHoryd wrote:
> On 9/7/26 08:40, Neil Armstrong wrote:
>> This means the nb7vpq904m is _not_ responsible for the AUX swapping, other
>> boards have the wcd9395 or the fsa4480 in the middle to use the AUX line
>> for the USB-C Alternate Audio support, and does the swap.
>>
>> Could you check in the vendor tree if there's any reference to those ?
> 
> Checked Retroid's downstream Android DT for this board. There is an
> FSA4480, plus a GPIO AUX switch, and my mainline port models neither.
> 
> 1. fsa4480@43, on the same I2C controller as the redriver:
> 
>       i2c@884000 {
>           fsa4480@43 {
>               compatible = "qcom,fsa4480-i2c";
>               reg = <0x43>;
>           };
>           redriver@1c {                 /* nb7vpq904m equivalent */
>               compatible = "onnn,redriver";
>               status = "disabled";
>           };
>       };
> 
>     The only node that references it is the ASoC machine driver
>     (qcom,kona-asoc-snd, via "fsa4480-i2c-handle") - so downstream it is
>     used for the USB-C analog-audio / MBHC SBU routing, not by the DP
>     driver. The codec is a wcd9385, no USBSS block, so no wcd9395 here.
> 
> 2. The downstream DP driver does its own AUX orientation over GPIO:
> 
>       &dp_display {
>           qcom,dp-gpio-aux-switch;
>           qcom,aux-sel-gpio    = <&tlmm 8  0>;
>           qcom,aux-en-gpio     = <&tlmm 9  0>;
>           qcom,usbplug-cc-gpio = <&tlmm 65 0>;
>       };
> 
>     TLMM 9 there is the same pin my mainline DT currently hands to the
>     nb7vpq904m as "enable-gpios", so that assignment is likely wrong, and
>     TLMM 8 (the orientation select) is not wired up in my port at all.
> 
> 3. The redriver (onnn,redriver @ 0x1c, same I2C address as the
>     nb7vpq904m on my board) is left status = "disabled" downstream.
> 
> So the SBU / DP-AUX orientation switch on this board looks like a
> discrete GPIO-controlled analog mux (TLMM 8 select, TLMM 9 enable), and
> my port is missing it - I modeled the I2C redriver as the
> orientation-switch instead, which is why poking its AUX_CC_REG did
> nothing and only the DP_CC2 (pair-swapping, 2-lane) op-mode ever got an
> AUX transaction through in reverse.
> 
> Does this look like a job for gpio-sbu-mux
> (drivers/usb/typec/mux/gpio-sbu-mux.c) - a node with
> select-gpios = <&tlmm 8>, enable-gpios = <&tlmm 9>, orientation-switch +
> mode-switch, wired to the connector - with the nb7vpq904m kept as
> retimer-switch only (or dropped, since downstream disables it)? Or is
> the FSA4480 in the DP AUX path as well, making fsa,fsa4480 the right
> orientation-switch to add?

Yes if it's a discrete SBU mux, gpio-sbu-mux was designed for that, and
keep the nb7vpq904m and just drop the SBU link to the redriver and replace
it with a link to the SBU mux instead.

Neil

> 
> I'll wire up gpio-sbu-mux and come back with reverse/normal traces
> unless that's the wrong direction.
> 
> Thanks,
> BurningHoryd

