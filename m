Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3F2C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A3710E487;
	Wed, 22 Jul 2026 15:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="PZSrIgUn";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D370F10E487
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1784732608;
 bh=aDN4gxD06vur8IKGGeUs8jFkZJdxML3nHWsnw+sJrVM=;
 b=PZSrIgUn9bH8pLKYry3fulH/+OaC0dE3ov/4d2nW/jiZBHtKpZUarqnLdW2E3Kphn0s1G34fB
 IBB5XC2fZFCTEPrIyxGrOq/VH0Wv5ABTU/FojdDoB65CcARSjwrgF1FtPn0bt+4fxpFnoiBKUw7
 0WkDGjm3cKa5+oLHnec53OORB7YJkT5QoCOTB6lw6dfbjkIy0S16PCbhDzsmReiLm0qI49vWPSO
 XA2qIUCIHqD5WTX4CctodmSAN1Aax1iZ8Qwyuvaj9YXuGGLce7OAbGlSkhOh6d12JUYvKwMli0R
 JfHQo0FjWGNbXjpADwi0j94pqesAZ6MGsEx6x3GtzjnA==
X-Forward-Email-ID: 6a60dbbed0a446977bf14c0a
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.12.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Wed, 22 Jul 2026 11:03:22 -0400
Message-Id: <DK56WN1AIY5S.30GUSMDS49CBZ@ubuntu.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [PATCH] drm/vkms: Advertise PREMULTI blend mode
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Joshua Peisach" <jpeisach@ubuntu.com>, "Michail Tatas"
 <michail.tatas@gmail.com>, <louis.chauvet@bootlin.com>, <simona@ffwll.ch>,
 <melissa.srw@gmail.com>, <mripard@kernel.org>, <tzimmermann@suse.de>,
 <airlied@gmail.com>, <hamohammed.sa@gmail.com>,
 <maarten.lankhorst@linux.intel.com>
X-Mailer: aerc 0.21.0
References: <al1pElMQZsDfpAYI@michalis-linux>
 <DK56F0N1D7ZA.1IYP6RGCYDI3T@ubuntu.com>
In-Reply-To: <DK56F0N1D7ZA.1IYP6RGCYDI3T@ubuntu.com>
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

On Wed Jul 22, 2026 at 10:40 AM EDT, Joshua Peisach wrote:
>
> Hi,
>
> Unfortunately, this still causes the warning on my machine. In my
> config CONFIG_DRM_VKMS is not set.
>
> -Josh

Sorry, disregard. This was meant to be a fix for just VKMS. I was lead
here by syzkaller thinking it would fix it for all.

-Josh
