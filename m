Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F60CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 06:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEAB1126C4;
	Thu,  4 Jun 2026 06:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="iTKojcA6";
	dkim-atps=neutral
X-Greylist: delayed 584 seconds by postgrey-1.36 at gabe;
 Thu, 04 Jun 2026 06:36:20 UTC
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE4981126C4
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 06:36:20 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 47C543F63E
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 06:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780554395;
 bh=vsMHKIFpUIhrPk0DECdef2DbD+vUYw7WHkW/xtElA+0=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To;
 b=iTKojcA6GmXO1gCYaRNq6AlODaOYIG+W65tPUjRleD7iQHYBAWydYgfUtUlvzJjhV
 SWu4rGDK9uiP0xi6a28I5nZw1+xGi1AR/si7J1GojeiFyimbwEFCEHfW+QHmfS+FAi
 6VC7ModqALO56EZIiJz8vGip0WMFo3Ydnba/7fyLpo0rA92kkzjrr5zV+9c9f7fCx7
 gl6xKCLMYIAohW/cBJ3e2j3eOWXufJybPkvdwdIeesO1dw8gqJrvi6C3qhnBlJ3++r
 ZvyQxIoBuSmLLido1V2Eue384RSrdM4TKh1rUq12qlBNmBtUlfJuM1mdjBiKPYkCq1
 yreFgV6TJFw8wMIw5cwGs5atyG8q0vEUiFv7rZVrsBmDq453Hgy/QJNp/d6q57Pkr6
 RJ4zHQ1Ae/I2+tGt5E5oTPCWUJ66zOc3JLE6Gx9e0n6a/bmwbAeXyudDDAH0jnwmiX
 wiBaFfDlisBR//pLvl0wQ/4B1UMH6i4HLiM7XHv9EUbqGL/043n0y83yINZK4sdS6V
 i9MaAJTHFIxf7V3mjg+iCNb1wo70JYaHzLDvPHwU3EHke4Y8bv5tgaGpMjQDElrOvp
 WQ7T1Ocn7MaQg3ysYoZtoDk18yfxu3JNrKLhJAoY0Cb+TdEVp/ZmeVwlmUprBtuWas
 GXC1H7VltAoSyKclGjGWjUVI=
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8423770d72dso490864b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 23:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780554394; x=1781159194;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vsMHKIFpUIhrPk0DECdef2DbD+vUYw7WHkW/xtElA+0=;
 b=d3vQW4yT+in8kXT7qPw+tymYwyXJP8mdEG9vxrEZC3xiD87wlPsk/0JXbrMlWJO32X
 3D6FDoUFft5mMM36RZlomEd+H3mE4rXZEZ7RLFEeLfF1i47g4yWwUzrcd8dtACDHCayf
 8ZzBWJM8PVjZbiMZXjTJVQ0wOaOnJhzA0XGYID9AJl6L7SZNTaiPGp8slrC04V89U6hY
 EUGBGTWFhJa3gL3ip8ZbRunVLtk1R4QyiiB1M6JHzNJur93G0G5AmHFPhVuoIpcKgQ4X
 wO/6uYIEVRRTS/n4ScAU7qKv8CD2GgfHLSXJhIwUPo4EBDiN9+lEIrUHGc23YYJydicX
 JfCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ90S8HjPQ0wLQNBPVFLxDFmqp70WqXfpHrIOnBu938gVcemMDDtSFJLCRsoYMYpixirXB/eq4OF+Oo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFXZB8xRD/XOgko55EUYW8cy5zo3RO66wd7o8x074jUbdQxmVv
 4oMyCPXPciUBwl288wn5phveR/czU27z7S8XwuIBvDAEeDZUhzOjlZ60L/I1AZHPatr4bVnx+fu
 jLi1wtY/CheCFBNs0skR7QLaa8nJsbZt5IXUPwFfMjxahaa4Z8NBSGWpYN+02TNOexKW6Ejh3Re
 4sVyhnsj/wedPbiQ+Hsg==
X-Gm-Gg: Acq92OFb/fw+5nrTDAR55FGurPcATLTqPXVbxx1/lROSEhNxnKjA7SUTE/z8JMs3d8u
 QGlnzQJF1R5N+tnwe5bJux9SxQETvl3qSnBxv4/53bCUZPj0SzJGSbJHJPKb6Cb13jYB9tBstSx
 E/VxzVhteRNT1CM1o9MM2CSvE3l8EMFeKa7OzHibR7t1Y7pj9mq6V3Bm7gSCbwAPGChZSkbAfGu
 iq4mUyy3Z9GdXZ4P2g9dkVdenSdl8TwV3duRO93alRngCLMf39yXNDVvZbBWjpJu5vaS6mgVfXk
 6cEHJKyQhMfWDdCzpWs5dT5NbclwJgeOrZAsuItamu05vu6SqBa7g6OkMEbN1IAOeH1oHl4nggp
 GpEGKALWL9sm0mqWTdvmlEuYNaQ0NM9eqUyTNC63znaRLKtVMLJmmhxOWu6m5QKdVJlGlGpi/IL
 RI+H5CIw28H1Ri
X-Received: by 2002:a05:6a00:1488:b0:842:6a97:52fb with SMTP id
 d2e1a72fcca58-84284dc0488mr6562709b3a.18.1780554393639; 
 Wed, 03 Jun 2026 23:26:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:1488:b0:842:6a97:52fb with SMTP id
 d2e1a72fcca58-84284dc0488mr6562689b3a.18.1780554393193; 
 Wed, 03 Jun 2026 23:26:33 -0700 (PDT)
Received: from acelan-Precision-5480 (211-75-139-220.hinet-ip.hinet.net.
 [211.75.139.220]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428706fa9asm4262986b3a.45.2026.06.03.23.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 23:26:32 -0700 (PDT)
Date: Thu, 4 Jun 2026 14:26:28 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com
Subject: Re: [PATCH v2] drm/dp: Add byte-by-byte fallback for broken USB-C
 adapters
Message-ID: <aiEZY48ZemmrS_E9@acelan-Precision-5480>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, 
 ville.syrjala@linux.intel.com
References: <20251204024647.1462866-1-acelan.kao@canonical.com>
 <685f4a41-b90c-4f8f-b4be-531eae1905ce@kernel.org>
 <61e9fb8c40b40fc6a1588b29bc2283fdaa313e1d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61e9fb8c40b40fc6a1588b29bc2283fdaa313e1d@intel.com>
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

On Fri, May 29, 2026 at 04:13:41PM +0300, Jani Nikula wrote:
> On Fri, 09 Jan 2026, Mario Limonciello <superm1@kernel.org> wrote:
> > On 12/3/25 8:46 PM, Chia-Lin Kao (AceLan) wrote:
> >> Some USB-C hubs and adapters have buggy firmware where multi-byte AUX
> >> reads consistently timeout, while single-byte reads from the same address
> >> work correctly.
> >>
> >> Known affected devices that exhibit this issue:
> >> - Lenovo USB-C to VGA adapter (VIA VL817 chipset)
> >>    idVendor=17ef, idProduct=7217
> >> - Dell DA310 USB-C mobile adapter hub
> >>    idVendor=413c, idProduct=c010
> >>
> >> Analysis of the failure pattern shows:
> >> - Single-byte probes to 0xf0000 (LTTPR) succeed
> >> - Single-byte probes to 0x00102 (TRAINING_AUX_RD_INTERVAL) succeed
> >> - Multi-byte reads from 0x00000 (DPCD capabilities) timeout with -ETIMEDOUT
> >> - Retrying does not help - the failure is consistent across all attempts
> >>
> >> The issue appears to be a firmware bug in the AUX transaction handling
> >> that specifically affects multi-byte reads.
> >>
> >> Add a fallback mechanism in drm_dp_dpcd_read_data() that attempts
> >> byte-by-byte reading when the normal multi-byte read fails. This
> >> workaround only activates for adapters that fail the standard read path,
> >> ensuring no impact on correctly functioning hardware.
> >>
> >> Tested with:
> >> - Lenovo USB-C to VGA adapter (VIA VL817) - now works with fallback
> >> - Dell DA310 USB-C hub - now works with fallback
> >> - Dell/Analogix Slimport adapter - continues to work with normal path
> >>
> >> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> >
> > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >
> > As this fixes reads for some existing hardware on the market and is just
> > in fallback path I feel this is low risk.  I've applied this to
> > drm-misc-fixes.
>
> I've stumbled on this when I was looking at drm_dp_dpcd_read_data(). I
> never received the original patch, for whatever reason, even though Lore
> says I was Cc'd.
This should be my problem that some receivers rejects my email,
because I'm using another email account to send the email.

I still have issues to send the email via company email account, and
hope this email won't be rejected.
>
> > a8f49a0043011 (HEAD -> drm-misc-fixes) drm/dp: Add byte-by-byte fallback
> > for broken USB-C adapters
> >
> >> ---
> >> v2. 1. Move the workaround from intel_dp_read_dprx_caps() to
> >>         drm_dp_dpcd_read_data(), so that it applies to all DPCD reads across
> >>         all DRM drivers benefit from this fix, not just i915.
> >>      2. Move the definition of drm_dp_dpcd_readb() before
> >>         drm_dp_dpcd_read_data()
> >> ---
> >>   include/drm/display/drm_dp_helper.h | 57 +++++++++++++++++++----------
> >>   1 file changed, 37 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> >> index df2f24b950e4..14d2859f0bda 100644
> >> --- a/include/drm/display/drm_dp_helper.h
> >> +++ b/include/drm/display/drm_dp_helper.h
> >> @@ -551,6 +551,22 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
> >>   ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
> >>   			  void *buffer, size_t size);
> >>
> >> +/**
> >> + * drm_dp_dpcd_readb() - read a single byte from the DPCD
> >> + * @aux: DisplayPort AUX channel
> >> + * @offset: address of the register to read
> >> + * @valuep: location where the value of the register will be stored
> >> + *
> >> + * Returns the number of bytes transferred (1) on success, or a negative
> >> + * error code on failure. In most of the cases you should be using
> >> + * drm_dp_dpcd_read_byte() instead.
> >> + */
> >> +static inline ssize_t drm_dp_dpcd_readb(struct drm_dp_aux *aux,
> >> +					unsigned int offset, u8 *valuep)
> >> +{
> >> +	return drm_dp_dpcd_read(aux, offset, valuep, 1);
> >> +}
> >> +
> >>   /**
> >>    * drm_dp_dpcd_read_data() - read a series of bytes from the DPCD
> >>    * @aux: DisplayPort AUX channel (SST or MST)
> >> @@ -570,12 +586,29 @@ static inline int drm_dp_dpcd_read_data(struct drm_dp_aux *aux,
> >>   					void *buffer, size_t size)
> >>   {
> >>   	int ret;
> >> +	size_t i;
> >> +	u8 *buf = buffer;
> >>
> >>   	ret = drm_dp_dpcd_read(aux, offset, buffer, size);
> >> -	if (ret < 0)
> >> -		return ret;
> >> -	if (ret < size)
> >> -		return -EPROTO;
> >> +	if (ret >= 0) {
> >> +		if (ret < size)
> >> +			return -EPROTO;
> >> +		return 0;
> >> +	}
> >> +
> >> +	/*
> >> +	 * Workaround for USB-C hubs/adapters with buggy firmware that fail
> >> +	 * multi-byte AUX reads but work with single-byte reads.
> >> +	 * Known affected devices:
> >> +	 * - Lenovo USB-C to VGA adapter (VIA VL817, idVendor=17ef, idProduct=7217)
> >> +	 * - Dell DA310 USB-C hub (idVendor=413c, idProduct=c010)
> >> +	 * Attempt byte-by-byte reading as a fallback.
> >> +	 */
> >> +	for (i = 0; i < size; i++) {
> >> +		ret = drm_dp_dpcd_readb(aux, offset + i, &buf[i]);
>
> drm_dp_dpcd_read_byte() should be preferred over drm_dp_dpcd_readb()...
>
> >> +		if (ret < 0)
>
> ...because drm_dp_dpcd_readb() might return 0 on failures. You need to
> use drm_dp_dpcd_readb() == 1 to check for success, which is why
> drm_dp_dpcd_read_byte() and drm_dp_dpcd_read_data() were introduced in
> the first place.
>
> Moreover, this ugly workaround only impacts drm_dp_dpcd_read_data()
> callers, but there are lots and lots of direct drm_dp_dpcd_read() calls
> all over the place, which go unfixed.
>
> It should be emphasized that DP AUX changes that affect absolutely all
> drivers should go through more scrutiny, and require more acks.
>
> This needs follow-up fixes.
I'll do some study and submit the follow-up fixes later.

>
>
> BR,
> Jani.
>
>
> >> +			return ret;
> >> +	}
> >>
> >>   	return 0;
> >>   }
> >> @@ -609,22 +642,6 @@ static inline int drm_dp_dpcd_write_data(struct drm_dp_aux *aux,
> >>   	return 0;
> >>   }
> >>
> >> -/**
> >> - * drm_dp_dpcd_readb() - read a single byte from the DPCD
> >> - * @aux: DisplayPort AUX channel
> >> - * @offset: address of the register to read
> >> - * @valuep: location where the value of the register will be stored
> >> - *
> >> - * Returns the number of bytes transferred (1) on success, or a negative
> >> - * error code on failure. In most of the cases you should be using
> >> - * drm_dp_dpcd_read_byte() instead.
> >> - */
> >> -static inline ssize_t drm_dp_dpcd_readb(struct drm_dp_aux *aux,
> >> -					unsigned int offset, u8 *valuep)
> >> -{
> >> -	return drm_dp_dpcd_read(aux, offset, valuep, 1);
> >> -}
> >> -
> >>   /**
> >>    * drm_dp_dpcd_writeb() - write a single byte to the DPCD
> >>    * @aux: DisplayPort AUX channel
> >
>
> --
> Jani Nikula, Intel
