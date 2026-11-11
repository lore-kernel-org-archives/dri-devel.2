Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BE606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=KnDYEbXU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C4C10FC84;
	Wed, 11 Nov 2026 17:52:44 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A492B10E34E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:52:37 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1794419556; mf=PGRlbGxlckBnbXguZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:pzjcqzVN1jdiHpCePzwNa3hfa77W
 3vQiTjq5YF3Wrf+TMr/bHy1meSjrQ0+lJ6jyDKiBMOJJe7aB8gto7ehrW5XT/n1tAUdUrqHeSUR
 h1HIylmEVFd0aYyq3N2rM/sV4rIhTm5tUwmBHQbfH2LuT9IqBsZrty24RCLfI8ftqmgb0qUpZF8
 +cXhqkVRnC3keBvEzm7aGPHZfBC3ZU1qsrgmIiQlcNiuT6lGUy+yLr6ZAWnPSyAXW/oLeeYEcWW
 CAlmQ3MoDxVFNY6wpivNK4BsxmEegbLi4nrJ161F/gMirjDZ283ChVj18q06v6jgR7uWvYCsFyF
 L9dt+HrwuFNXZA==;
Message-Instance: m=1; h=sha256: Y6MaMyDtNgrI/yxmrlSSJdqjUwPo7p6jBktWzpcA4dg=:
 kuuv3J/mIVua0AdQlk7VtbdEG+8VQT8+6Sou1I8x8JY=, sha512:
 tCHhNFPdWNUCmSBhBDdzcnElZB1zqovS/dwmQjC9Ciw6aGI9dQXDvcHRZ5sOFr7o8hiV1+GBWfrmmS0ZCR8w/w==:
 zX3B44FNbx/tLgeL1JoqCDxSg2gGBIYr+ijIX7bEeCkAJAXzWVk926/KPV1NpKYW/pKfbe5VQZdEju2/ypZC9w==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794419529; x=1795024329; i=deller@gmx.de;
 bh=2nS32iMFC6roml0FYhlr4Uqx+HDK3XjQ7OWAzyep86g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KnDYEbXUwRufaTEmOz9uXSeWw3hJPvQ3WpcrFdjf921C/YVuw9rmF4h/LUUfhv4U
 AuDxPQ8S3WI8TETJJ8zAGXdbKz5jWzLk3s5sEX4KH1o2RuCblgjNfYyXRDG2XARQu
 Aom+/zqNA5rDSQT8e8+ENnRepe/wuFxp0taKsoi92FzurNulcWNIElZCV5QS/7ORc
 qHAVixy8bO9IhqSGFKTX3djTGjXWWuYwrh6fya4Ttfh9X8ELgZDnt+g4vD6Mp0pqA
 MNcXxcWTbFA2wPiqSRtz8V9CxOB+e7ZZ2+wOzvtZy5KvpUtagajh3S2ak9jOQyLiH
 4gSxXEpJzMNXmIX5nw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYLQ-1wpfsn0RPU-00jbWb; Wed, 11
 Nov 2026 18:52:09 +0100
Message-ID: <9330c733-bb42-4bfb-bdec-d012b651475e@gmx.de>
Date: Wed, 11 Nov 2026 18:52:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fbdev: simplefb: Add mono framebuffer format
To: Thomas Zimmermann <tzimmermann@suse.de>, Sebastian Raase <linux@sraa.de>
Cc: Hans de Goede <hansg@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1793758480.git.linux@sraa.de>
 <6c207278c23d11f2c17cee383d422c3295cc7d97.1793758480.git.linux@sraa.de>
 <16220356-767a-4f1d-9b24-5b1f960e04cb@gmx.de>
 <1b37c7d3-f8d0-4023-b0bc-4770ec2b17d6@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <1b37c7d3-f8d0-4023-b0bc-4770ec2b17d6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IjPArBRrdLsfRnJKyuJgFnJRlSydzSJBU7ZN/wgjpcTdWBbjrPR
 NOGtuFKFqhlz1pd9AwyKruUm5tiVoNkXTRE0jqjiiFgZ163AdsMUW22YQxh5XhgZPcb42Tc
 9k8rZG9Ls1k6oMY3JA2Db7DtECUwxATPLWMHabzIFGQk9cZYmT7qndliNe5MBDI+wCGA5pz
 DzWchn7sZh7fXanNu1kzA==
UI-OutboundReport: notjunk:1;M01:P0:yIqY7v66A6A=;EME8SDBF1BuOx3LkEy6NTgI1F/x
 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
 dV5irnVSTGsVPZY3EPC18U7GDUwaaJVE
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 16:27, Thomas Zimmermann wrote:
> Hi Helge
>=20
> Am 11.11.26 um 00:25 schrieb Helge Deller:
>> On 11/4/26 03:34, Sebastian Raase wrote:
>>> Add a new simple-framebuffer format for monochrome 1 bit-per-pixel
>>> framebuffers. Monochrome framebuffers are not true color, so their
>>> visual is set to FB_VISUAL_MONO10 (set pixels are bright).
>>>
>>> Signed-off-by: Sebastian Raase <linux@sraa.de>
>>> ---
>>> =C2=A0 drivers/video/fbdev/simplefb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 2 ++
>>> =C2=A0 include/linux/platform_data/simplefb.h | 1 +
>>> =C2=A0 2 files changed, 3 insertions(+)
>> series applied to fbdev git tree.
>=20
> Isn't that a bit premature? There's no use-case give; except because-
> we-can.  And doesn't it require a review from DT maintainers?

I'm happy to add any Reviews or Acks, or drop it again if there are any ob=
jections.

Helge
