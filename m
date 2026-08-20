Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A77C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7CE10F163;
	Thu, 20 Aug 2026 18:28:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bitmer.com header.i=@bitmer.com header.b="I1pDRHQG";
	dkim-atps=neutral
X-Greylist: delayed 2094 seconds by postgrey-1.36 at gabe;
 Thu, 20 Aug 2026 18:28:39 UTC
Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4A110F16B
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 18:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com; 
 s=default;
 h=In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Content-Type:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2xFTXyLuCPD7M6C46OVih8IxHyoiVmFVZ/4nP+wEEJM=; b=I1pDRHQG4DIEKgvnupdpvbL1CZ
 LbGujrGwgy9MiFqPK9Td+Di3Io1KPzwqzJTN6J/jJstg4Uv0h8AyyhokJ2opp61QtFNCmo0NOLji0
 S0KyMo3Pm5pHg5AZhxCzruqADs/3Ak+tYEusDQMP+jpMRS8WPN0psmDXGg4tTKc6YYtjB4nOQWQ8Q
 Qw8ay470GusDro9FofwJaZdyB4mDwa1fAenifvxeqZTALhAJr6ooowpso1pb+LtPe9N6yoskNe16a
 RZ0tn/mbg/K0KC9xbf5viGAtPGEgtjdFwO8NJm0VHxRHa/eLAm/cZPBQV6E4ryhsHKvy5lRP45Rn8
 POfNI/kA==;
Received: from 91-157-129-96.elisa-laajakaista.fi ([91.157.129.96]:44776
 helo=[192.168.0.12])
 by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.5) (envelope-from <jarkko.nikula@bitmer.com>)
 id 1wx6xR-0000000CerP-0pZZ; Thu, 20 Aug 2026 20:53:40 +0300
Content-Type: multipart/alternative;
 boundary="------------HAax7ketJU2g3AHi5IZpkEd7"
Message-ID: <f0cf25b5-fadf-445e-abca-2c888300f3f6@bitmer.com>
Date: Thu, 20 Aug 2026 20:53:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/omap: Report HDMI hotplug events to the ASoC HDMI
 codec
To: Mark Brown <broonie@kernel.org>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org
References: <20260819171935.233946-1-ivo.g.dimitrov.75@gmail.com>
 <97c54f93-d929-40dc-9899-0f8a0b09b0e6@sirena.org.uk>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <97c54f93-d929-40dc-9899-0f8a0b09b0e6@sirena.org.uk>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - wp23.hostingpalvelu.fi
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bitmer.com
X-Get-Message-Sender-Via: wp23.hostingpalvelu.fi: authenticated_id:
 jarkko.nikula@bitmer.com
X-Authenticated-Sender: wp23.hostingpalvelu.fi: jarkko.nikula@bitmer.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

This is a multi-part message in MIME format.
--------------HAax7ketJU2g3AHi5IZpkEd7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/08/2026 8:21 pm, Mark Brown wrote:
> On Wed, Aug 19, 2026 at 08:19:35PM +0300, Ivaylo Dimitrov wrote:
>> The OMAP HDMI audio driver currently has no way of reporting HDMI cable
>> hotplug events to ASoC. As a result, user space cannot detect HDMI audio
>> availability through the standard jack mechanism and audio policy managers
>> cannot automatically route audio to or from the HDMI output.
> Acked-by: Mark Brown <broonie@kernel.org>
>
> Please carry acks forward if you're not changing something relevant or
> substantial :(
For the sound/soc/ti/omap-hdmi.c and tested on old PandaBoard EA1:
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com> Tested-by: Jarkko
Nikula <jarkko.nikula@bitmer.com>
--------------HAax7ketJU2g3AHi5IZpkEd7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 19/08/2026 8:21 pm, Mark Brown
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:97c54f93-d929-40dc-9899-0f8a0b09b0e6@sirena.org.uk">
      <pre wrap="" class="moz-quote-pre">On Wed, Aug 19, 2026 at 08:19:35PM +0300, Ivaylo Dimitrov wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The OMAP HDMI audio driver currently has no way of reporting HDMI cable
hotplug events to ASoC. As a result, user space cannot detect HDMI audio
availability through the standard jack mechanism and audio policy managers
cannot automatically route audio to or from the HDMI output.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Acked-by: Mark Brown <a class="moz-txt-link-rfc2396E" href="mailto:broonie@kernel.org">&lt;broonie@kernel.org&gt;</a>

Please carry acks forward if you're not changing something relevant or
substantial :(
</pre>
    </blockquote>
    For the <span style="white-space: pre-wrap">sound/soc/ti/omap-hdmi.c and tested on old PandaBoard EA1:

Acked-by: Jarkko Nikula <a class="moz-txt-link-rfc2396E" href="mailto:jarkko.nikula@bitmer.com">&lt;jarkko.nikula@bitmer.com&gt;</a>
Tested-by: Jarkko Nikula <a class="moz-txt-link-rfc2396E" href="mailto:jarkko.nikula@bitmer.com">&lt;jarkko.nikula@bitmer.com&gt;</a></span>
  </body>
</html>

--------------HAax7ketJU2g3AHi5IZpkEd7--
