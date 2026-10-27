Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B832606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=meijers.dev header.i=@meijers.dev header.a=rsa-sha256 header.s=november2021 header.b=ANLKdLk6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9267011202A;
	Thu, 29 Oct 2026 07:58:57 +0000 (UTC)
X-Greylist: delayed 550 seconds by postgrey-1.36 at gabe;
 Tue, 27 Oct 2026 20:47:10 UTC
Received: from mail.meijers.xyz (mail.meijers.xyz [31.220.73.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 162B310E4DC;
 Tue, 27 Oct 2026 20:47:10 +0000 (UTC)
Content-Type: multipart/alternative;
 boundary="------------3D9ybPL9HaYFAritpMd1hywW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meijers.dev;
 s=november2021; t=1793133478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTw2D4cfGAFjGPqxOreYKB4D3AyzOci5nPVHSmhz6gw=;
 b=ANLKdLk6T7sdWBcm8W8X2hh52ZW8/lizpdA+e+9TSLtwAWMH826x8TliPt9uXS7pNvlMX9
 H551semzcLXlJrt0pWmTQkapqfrBrtP93zDpHMMfyAuQ77F2mSY6JRRTym7KkoepnRH3x6
 8G/0u3dxZjAEdqIqzf4IJYeG64sSuIQ=
Message-ID: <e50a86b3-0b7a-441b-9ade-d21d8122a246@robert.meijers.dev>
Date: Tue, 27 Oct 2026 21:37:50 +0100
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
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------3D9ybPL9HaYFAritpMd1hywW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

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

--------------3D9ybPL9HaYFAritpMd1hywW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi,<br>
      <br>
      (First up this is the first time I'm participating on a mailing
      list,<br>
      so sorry in advance if I'm doing something wrong).<br>
      <br>
      <span style="white-space: pre-wrap; display: block; width: 98vw;">&gt; Add support for Multi-stream transport for MSM chipsets that allow
&gt; a single instance of DP controller to send multiple streams.
&gt; 
&gt; This series has been validated on sa8775p ride platform using multiple
&gt; MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.
&gt; 
&gt; With 4x4K monitors, due to lack of layer mixers that combination will 
&gt; not
&gt; work but this can be supported as well after some rework on the DPU 
&gt; side.
&gt; 
&gt; In addition, SST was re-validated with all these changes to ensure 
&gt; there
&gt; were no regressions.
</span><br>
      I have applied this patch series onto a near mainline 7.3 tree for
      the<br>
      Xiaomi Pad 6s Pro ("Sheng"), with SM8550. But with these patches<br>
      applied I don't have working audio, over USB-C to my (DisplayPort)<br>
      monitor, anymore. If I disable MST support on the monitor audio
      works<br>
      again. Debugging (using AI) reveals that the DP0 Jack is not
      reported as<br>
      connected anymore when connected to the monitor, with these
      patches<br>
      applied and MST enabled on the monitor. As shown, for example, by<br>
      amixer:<br>
      <br>
      $ amixer -c 0 contents | grep -i -A8 -B3 -E
      'hdmi|displayport|jack'<br>
      numid=208,iface=CARD,name='DP0 Jack'<br>
      ; type=BOOLEAN,access=r-------,values=1<br>
      : values=off<br>
      <br>
      With MST on the monitor disabled this outputs "values=on". The
      same is<br>
      also reflected by "pactl list cards" and "pactl list sinks" where<br>
      HDMI/DisplayPort is reported as "not available" with MST enabled
      (and<br>
      "available" when disabling MST).<br>
      <br>
      (Again, suggested by AI) I also checked the ELD, which in both<br>
      cases (MST on and off on the monitor) is identical, including
      audio<br>
      information (like "speakers [0x1] FL/FR"). (Also, audio works both
      using<br>
      an AMD and an Intel based laptop, in which case I can also choose<br>
      whether to use "HDMI" or "HDMI 2" to switch audio output between
      two<br>
      monitors, in daisy chain).<br>
      <br>
      So my foremost question is: should audio be supported in case of
      MST,<br>
      after applying these patches? Or is this possibly out of scope?<br>
      <br>
      For clarity I would also like to note that without these patches<br>
      applied audio over DP does work as well, irrespective of MST being<br>
      on or off on the monitor (obviously always running as SST because
      of<br>
      missing kernel support). Which would make me believe that no audio<br>
      support in the same setup might be considered a regression?<br>
      <br>
      Note that I do understand that me running a forked kernel on a<br>
      (by upstream) unsupported device might also lead to issues or
      require<br>
      changes for the fork. And that if audio does work with MST then
      this is<br>
      something the maintainers of the fork should, most likely, fix.
      But<br>
      from the cover letter and commit messages it is unclear to me
      whether<br>
      audio support should work and/or has been tested when MST is in
      use.<br>
      <br>
      Kind regards,<br>
      Robert</p>
  </body>
</html>

--------------3D9ybPL9HaYFAritpMd1hywW--
