Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE1606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xO7M/l50
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8417410E644;
	Sun, 22 Nov 2026 17:14:37 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD5010E5FD
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 16:59:58 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so2022340f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795366797; x=1795971597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0mnruJCi4gXWgtrWNMhLBNdhM+30e2MaNeSeot4jHHo=;
 b=xO7M/l50vsdt7Nu8jpGrXkAVrmKWF/iGMF3Aa4BoU1FeCFmxybAM33Xto0uA3FrRxE
 vqe+U9GdAgg15r+DXz3A1RiHaj52+W3lGEkDNq2oTbDIO2feV4KjRcOwNnB9mKZhH6hx
 hBFYUKhjZWKjaxNHb9Qevnsooyzn0Weu1YPTvC7k+RpI6XmR5gzyntuojnVqmV9o2lp1
 K5kINAgGMVuOaD6mUcbI8xNsOPy7CBQl+98WZ/2kVOSkamZGsCfix+yyGX3XgWSRnWyO
 7ZFc3Mhz2Wcvb8mbCt3bx0207pYESq0XrhkbBsjYVguo6xT10OvW9t+P0snM1oR97vcJ
 Hfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795366797; x=1795971597;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0mnruJCi4gXWgtrWNMhLBNdhM+30e2MaNeSeot4jHHo=;
 b=g6YZhO3IunBmhzpqA/MQyNQ8BUuLgzxnyZF1QrTaGER5a1EMZWb3nXrWXp+1BQrWOa
 RnJjsQFzdaRjOlttbQpOiYzvG7X+xrBQjrHOH2unYrs8DLwVL4V64iaUybCJ2a+1+8LJ
 4/FsLKM+jpbvqVdfiYWSzQyH4g50WJS+THs2x3seGMv2zjFZtjc6QTq/QutS94+l1rJ6
 JON/h9fpKBSsJpBb/QTdywwxkQff8us8q/0v2YrP35Q3PNOpMcXMCVPPWIqtG1OMWxr7
 +qK/b/fgqERrMwcrPS4znj3SjcTiljrPVNs8NkHtj3oYT2RV6NWPK7dwd3PNW0LSwKlE
 0KOg==
X-Gm-Message-State: APuU4Z//zAh4Tgr1A+JjU0W/LCpHX5ott/4JeZoiqH9qft4ry9ceQDUr
 TsIvP+Yp2TS3dCFRdV4qt2s+kOHtf6so5FbC2OWF1XQxhVozGjepqsol
X-Gm-Gg: AZFdTZcRMtiT4PiQfdX5a+wGZSeWa31t0hVdFog50pvfZ2ZCJj8nrtNxVORyOJat5N3
 0LbHFiiwDo2FcAFJGendi3Yt7tlk2PqOeFojsk9fBm6ZVXCKH4m+7knAMZNdeyJxYL11YlC5Slv
 YZPJtzlmRniGD66gj3A7aUZGdeGKCxAT1z2crgNDLvMwbZb2S4TrsGANvZVhxudrgR1nO3744N9
 bmV508vAInKq/VVkV99mN2Fkw2I+wyds/8yhcfbbCChmr8f1v5okkZ0veN0l7qRq2sDZkJcqLEo
 qj5GDO5m+EpORVHnwR5rUdRcAwzXxCCdtGK7YEQYddns2ocfmlGYEDK5K+Doi5oCGyx+8ZmDx9s
 5Gp01O8CNpN4PJVBIhF9d02U0Cqj5+x0ff4U3FhrE+Yem1qe9/vLWuoDaQit4sVXX5s7Pe/Yn+f
 RkeM372UrN+BTx/Z+sAIHme2Sy0UWx5g/rtuNEPv1w8+s1XK17ZmLuZSQei6iG6TUOpZcSk+VhD
 /oa1GKQtjoJ4OIzcBJaWqh6pJmBk+B5WjF1hpgrjIcoeCE1XlyIUdFhCy3/ZRZ616e/XMEM3lRH
 AtazkrINhTK0QnNqefFYvwAbyq0kgSGsOc/Bb3uHMV2pKTgaagKfCu23mrxjLb7YicnIudsJS/J
 VNGD5CjYClAMryszSr0rFGQ==
X-Received: by 2002:a05:600c:154c:b0:4a2:1364:252a with SMTP id
 5b1f17b1804b1-4bb887c28a8mr197658875e9.3.1795366796946; 
 Sun, 22 Nov 2026 08:59:56 -0800 (PST)
Received: from [192.168.10.197]
 (cpc92320-cmbg19-2-0-cust1861.5-4.cable.virginm.net. [82.13.71.70])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61f558sm17541739f8f.58.2026.11.22.08.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 08:59:56 -0800 (PST)
Message-ID: <519cee89-1315-4edb-90cd-fa99e6eabf77@gmail.com>
Date: Sun, 22 Nov 2026 16:59:54 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Testing: [PATCH v4 4/4] drm/i915/dp: Always write the HDR content
 luminance
To: Yitian Shao <fighters390@qq.com>, intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
References: <20261121013532.21135-1-fighters390@qq.com>
 <tencent_4B4D5022969E4FEF24BDDD2C4993D2D39709@qq.com>
From: Daniel Green <danielgreenhome@gmail.com>
Content-Language: en-US
In-Reply-To: <tencent_4B4D5022969E4FEF24BDDD2C4993D2D39709@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tested-by: Daniel Green <danielgreenhome@gmail.com>

I've tested the above set of 4 patches locally on an Asus Zenbook ux535, 
I can confirm that these correctly enable HDR on my internal monitor.

On 21/11/2026 01:35, Yitian Shao wrote:
> intel_dp_aux_write_content_luminance() skips the DPCD write when the
> encoder cannot send a gamut metadata SDP. That is backwards: the DPCD
> register is what the AUX HDR interface uses on those platforms.
>
> Drop the check instead of inverting it. INTEL_EDP_HDR_TCON_SDP_OVERRIDE_AUX
> already tells the TCON whether to use the SDP or the DPCD value, so the
> write is harmless where the SDP takes precedence.
>
> Signed-off-by: Yitian Shao <fighters390@qq.com>
> ---
>   drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 8c7fd99..6b33ba0 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -250,9 +250,6 @@ intel_dp_aux_write_content_luminance(struct intel_connector *connector,
>   	int ret;
>   	u8 buf[4];
>   
> -	if (!intel_dp_has_gamut_metadata_dip(connector->encoder))
> -		return;
> -
>   	buf[0] = hdr_metadata->hdmi_metadata_type1.max_cll & 0xFF;
>   	buf[1] = (hdr_metadata->hdmi_metadata_type1.max_cll & 0xFF00) >> 8;
>   	buf[2] = hdr_metadata->hdmi_metadata_type1.max_fall & 0xFF;
