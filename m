Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F02CDE013
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E812310F49E;
	Fri, 26 Jun 2026 07:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=haghiri.net header.i=@haghiri.net header.b="jWOEIgwD";
	dkim-atps=neutral
X-Greylist: delayed 900 seconds by postgrey-1.36 at gabe;
 Thu, 25 Jun 2026 20:01:01 UTC
Received: from a4i518.smtp2go.com (a4i518.smtp2go.com [158.120.82.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C019F10E270
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haghiri.net;
 i=@haghiri.net; q=dns/txt; s=s670074; t=1782416760; h=from : subject :
 to : message-id : date;
 bh=4FDASpAZewTAw9aVPec4IBz0vmR8o1gLUU6QhtvS7Ek=;
 b=jWOEIgwDzN6IxzGkfmaIDJdwIcvz/752UpE7+4sEwaRCtVrhSpus13r/z4cwCB24EMwYU
 /PNU3iboiFql9Qb4U/8BRufOVCUXmPn+UX6Jf60I9IKiXtSpekoYvPhK2x84njzQHUTcTm5
 bbM7cnZR1r+YuPxx5Guadn4U34fQmGl2DEpN+dxHZtkJtSMBWE+wasD31W6LUeNEXlM7pXo
 hCmJBNgfvVnuhc7jmaYz6sHxsrg0rT/ebDX1GYkK6fBet08z+HFoJ9PBvy0czduQUkUrvOm
 IiJwWQ3v/O+I80NsW3yRKIfcFzFWNzF8z1wTGUAX7nuayt01d7QDwr+vbzKA==
Received: from [10.132.241.142] (helo=[10.161.48.225])
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.99.4) (envelope-from <nick@haghiri.net>)
 id 1wcq1C-4o5NDgrhWwe-hkHe; Thu, 25 Jun 2026 19:45:46 +0000
Message-ID: <8e62f139-1d61-433e-8029-b10025a289d3@haghiri.net>
Date: Thu, 25 Jun 2026 15:45:44 -0400
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [RFC PATCH] drm/amd/display: extend HPD debounce filter to
 DisplayPort SST
To: Ivan Lipski <ivlipski@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260625150439.330875-1-nick@haghiri.net>
 <928d4c2a-d8b7-43d7-995e-a3e6996d2952@amd.com>
Content-Language: en-US
From: Nick Haghiri <nick@haghiri.net>
In-Reply-To: <928d4c2a-d8b7-43d7-995e-a3e6996d2952@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 670074m:670074aX29xAY:670074syjoatcHpi
X-smtpcorp-track: 7TmxRKC10Mxz.1W4UKhm-YPBV.jJLPtAikZVd
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

On 6/25/26 3:15 PM, Ivan Lipski wrote:
 > I don't think I've encountered a situation when a monitor with DP can
 > wake a system up from DPMS, so that's interesting. What distro and
 > desktop environment are you using? I'd like to reproduce this issue
 > and help with it.

openSUSE Tumbleweed, KDE Plasma 6.7 on Wayland (KWin). GPU is an RX 9070
XT (RDNA4), monitor is an MSI MPG 274U over DisplayPort SST.

What happens: when the output goes DPMS-off and the monitor drops into
deep sleep, it briefly de-asserts and re-asserts HPD. amdgpu forwards
that as a hotplug, KWin re-probes and re-enables the output, and the
panel comes right back on, so it never actually stays asleep while
connected.

I suspect the monitor's input auto-scan plays a part, but disabling 
auto-scan on the monitor did not stop the HPD toggle, so it looks like 
panel-side behavior on entering deep sleep rather than something the 
user can turn off.

To watch it, enable drm logging:
   echo 0x16 > /sys/module/drm/parameters/debug
then force DPMS-off on the DP output (kscreen-doctor --dpms off, or just 
let it idle). On the stock driver you get a link_set_dpms_off quickly 
followed by a spurious detect and a link_set_dpms_on. With the debounce 
set, the toggle is coalesced and it stays off.

I am happy to send the monitor's EDID and a full drm.debug trace 
off-list if that helps. Its EDID identifies as manufacturer MSI, product 
code 0x3CF0, i.e. drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0) for 
the apply_edid_quirks() switch.

 > I think generalizing the hpd_debounce_delay for both DP and HDMI would
 > be better.

If you're open to it, I will fold it into a single hpd_debounce_delay_ms 
that applies to both HDMI and DP SST (eDP and MST still excluded), and 
rename the internal hdmi_* field, work, and prev_sink to generic hpd_* 
while I am there.

One question on the existing knob: hdmi_hpd_debounce_delay_ms already 
shipped. Would you rather I keep it as a back-compat alias of the 
generic one, or just replace it since it is only a couple of cycles old? 
I will go with whichever you prefer.

 > Maybe we can also enable hpd_debounce_delay by default for monitors,
 > that are known to have this issue, using apply_edid_quirks

I like that. It could make it work out of the box instead of needing a 
module param. I can add an apply_edid_quirks() case for the MSI MPG 274U 
(panel id above) that sets a sane default, and keep the module param as 
a global override. 1500 ms is what reliably works in the testing I've 
done, but I can tune that down if you want a smaller default.

Thanks for the quick and helpful review.

--

Nick Haghiri

