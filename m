Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01B606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=meijers.dev header.i=@meijers.dev header.a=rsa-sha256 header.s=november2021 header.b=T+Mr2MVB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF46B112049;
	Thu, 29 Oct 2026 07:59:10 +0000 (UTC)
Received: from mail.meijers.xyz (mail.meijers.xyz [31.220.73.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D66710F82E;
 Tue, 27 Oct 2026 21:04:58 +0000 (UTC)
Message-ID: <c329cd0a-1396-4a71-a0cb-6921427f7699@robert.meijers.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meijers.dev;
 s=november2021; t=1793135096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLUULcZ5Th52iRf5h59OCF/dLSjqO3QJ39mbKLqDk+w=;
 b=T+Mr2MVBqJTteemE/FpH+pdk14MnOWJ2BrL3gGV070LFD9pyzVzVHgoLn+6eiak3tye70T
 bHo6baFlsIpY+KgOYYBLCXyKvyzx3EEowhD3L/LpG+ROAKzVokMx6/Gp1vygeqagqgQGhK
 SNpbd+duEmX+LSwgvf7zjZPnxL5O9cY=
Date: Tue, 27 Oct 2026 22:04:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
To: yongxing.mou@oss.qualcomm.com
Cc: abhinav.kumar@linux.dev, airlied@gmail.com,
 dmitry.baryshkov@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, jesszhan0024@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, marijn.suijten@somainline.org, quic_abhinavk@quicinc.com,
 robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch,
 stable@vger.kernel.org
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
Subject: Re: [PATCH v7 00/35] drm/msm/dp: Add MST support for MSM chipsets
Content-Language: en-US
From: Robert Meijers <linux@robert.meijers.dev>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

((Sorry, re-sending because the first was rejected for not being plain 
text))
(First up this is the first time I'm participating on a mailing list,
so sorry in advance if I'm doing something wrong).

> Add support for Multi-stream transport for MSM chipsets that allow > a single instance of DP controller to send multiple streams. > > 
This series has been validated on sa8775p ride platform using multiple > 
MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P. 
 > > With 4x4K monitors, due to lack of layer mixers that combination 
will > not > work but this can be supported as well after some rework on 
the DPU > side. > > In addition, SST was re-validated with all these 
changes to ensure > there > were no regressions.
I have applied this patch series onto a near mainline 7.3 tree for the
Xiaomi Pad 6s Pro ("Sheng"), with SM8550. But with these patches
applied I don't have working audio, over USB-C to my (DisplayPort)
monitor, anymore. If I disable MST support on the monitor audio works
again. Debugging (using AI) reveals that the DP0 Jack is not reported as
connected anymore when connected to the monitor, with these patches
applied and MST enabled on the monitor. As shown, for example, by
amixer:

$ amixer -c 0 contents | grep -i -A8 -B3 -E 'hdmi|displayport|jack'
numid=208,iface=CARD,name='DP0 Jack'
; type=BOOLEAN,access=r-------,values=1
: values=off

With MST on the monitor disabled this outputs "values=on". The same is
also reflected by "pactl list cards" and "pactl list sinks" where
HDMI/DisplayPort is reported as "not available" with MST enabled (and
"available" when disabling MST).

(Again, suggested by AI) I also checked the ELD, which in both
cases (MST on and off on the monitor) is identical, including audio
information (like "speakers [0x1] FL/FR"). (Also, audio works both using
an AMD and an Intel based laptop, in which case I can also choose
whether to use "HDMI" or "HDMI 2" to switch audio output between two
monitors, in daisy chain).

So my foremost question is: should audio be supported in case of MST,
after applying these patches? Or is this possibly out of scope?

For clarity I would also like to note that without these patches
applied audio over DP does work as well, irrespective of MST being
on or off on the monitor (obviously always running as SST because of
missing kernel support). Which would make me believe that no audio
support in the same setup might be considered a regression?

Note that I do understand that me running a forked kernel on a
(by upstream) unsupported device might also lead to issues or require
changes for the fork. And that if audio does work with MST then this is
something the maintainers of the fork should, most likely, fix. But
from the cover letter and commit messages it is unclear to me whether
audio support should work and/or has been tested when MST is in use.

Kind regards,
Robert

