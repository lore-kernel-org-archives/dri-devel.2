Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5B1CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 221BD10E40B;
	Fri,  2 Oct 2026 08:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o/OOJ1T9";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ECDF10E6B4
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:57:00 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so3334004a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 01:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790931420; x=1791536220; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cpvwnxAk9svVbGHuD977nmsMKCoPbElte6mylNvKXkA=;
 b=o/OOJ1T9b2VVzeIgIiJQoOOFQyoPOASziHAsPB7Bj0miCON8swrDY7VLauwvWCXnR4
 V1HiWz/nRLO7RWI7Ysb8sEJ/lyqAXx4rg0CZFf7PjnHwIcCYFlemMb63DOnlyw2UE9hI
 BQ0LahYJTgJyzokehHzXk045Ni+h02zCQasRNsBD7m+r8u4Vda0tTgCYvaIo9JklYOeM
 +P5U2/ivaoqIRUtoAZq1xmaEf0cASPRp2Yf6JYMEU9oTii0gpIpnhtoiK0KRy9pJhArC
 jtteE7EkVDC1lGM9HlMyuebKto4Jfdhvht8a3GHqvxq8J5FwOJz1XToG/eTGlimHvDY8
 knHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790931420; x=1791536220;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cpvwnxAk9svVbGHuD977nmsMKCoPbElte6mylNvKXkA=;
 b=D2oTLmGNp7cqXQmzTQa1QPcFvBtKkInQ/jhrIB9GHBW9YYhA7Lgu2uSyPupKApu+DQ
 s9d0qAzk7qc9JYx9waG6OUvlhi0mQbsiD83HFTHpaxO0UREVofRKlQOvMSizzzHgOmV6
 lJJtRYOQN3GU+/4hj97u+LgHrnJTJlnZD0r2isrK8AE/7NoHWdj9Fj55fXfCt63MD7kn
 xoM1Ao+6apFU8WrqT7rCguyx6N5XrRA543BKi2HmSfSNWVEf4OrxvxdtOk5XMTmcHZrz
 9WFe1p6Cx8ucRzoWqxznzW5koQ0FI+8z8N6N7jbZ2HvSmPqHiXIIp88em9XqE+AQWdf4
 2kDA==
X-Forwarded-Encrypted: i=1;
 AKwUvByj3RITZz4orSUxvN6/yVeekWQQmY/v4gLGixHZb+yCdyXTuNhsWdKoS3vEZ/6VqY0c5P2msHUyQ+8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI+hR4NQJhYJSlC07Hked+1JteIj/sx2mttJJbkef7FA0jrCcmk
 zCV8dWsL4TIic4Dk0UAe797KFGOctBhssAnMHqxdBds7dabBi3lf+PMzuDYzqLRr
X-Gm-Gg: AYBFou1wStpv5s2hDWojhbYaj0uvzVpVcc+dYjci0pjw8Kd2o3lLl+o9pEleeoVTxov
 wKpCN7pTv4GkZWMQlzNK/+UmocF7zdOaPu7k3yVYqNXYlGhQ/8M4/BZ8EeUS2vH4s+unkkQtxwI
 3YcvvSLrYmo4vsYWETD6HN42hWmMzJgeNLitdNwtuwbSN/ycauVX7Z4/Rv9eXOUCgPAV7Akdgdx
 YPh/lEpAwOzIpWOucLTNSXVmkW8/Zb86E0gC+WDULZ7XB05oH+KY5Q2der19pOLqNL+0uvJDu7a
 J8XAb4nn4ZHanSOlJTqgQtPVeFC/dK8mA7DOkuzWDrZ7cC3wEBPAXius17Udz3cOY0OG3g+8wcM
 HIHxlutrQBUPsoTn2B19b5z2z9s8pj+vCIM4pckxpcmU7IeVwPvwSLyU565yClOnsc9J0zDAK23
 Cny7vPNoa87HDmiZzkzQAI82M/hgbV/4VChEfCns0cbg3AnnpXkadnOkeFC5eMokdkAM06sdSY1
 kT7e/0wsrbAs1aznDvBD3uNY86gu/TTWast+Y/O8OM0QuFVSR8fIeA3kEor11ExJ9ntl54Yasvy
 lEymn4IvRgjLOUKEWbtDHLANp8UOwRrSVPMB+2rShRNVE1YrIMnlVX8=
X-Received: by 2002:a17:90a:c88d:b0:3a4:ee64:f492 with SMTP id
 98e67ed59e1d1-3a6cec30c01mr1156984a91.33.1790931419389; 
 Fri, 02 Oct 2026 01:56:59 -0700 (PDT)
Received: from B11403806-N.ieinet.org (211-23-39-77.hinet-ip.hinet.net.
 [211.23.39.77]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4747100sm7956667a91.11.2026.10.02.01.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 01:56:58 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: devarsht@ti.com
Cc: airlied@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kristo@kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, nm@ti.com, robh@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, vigneshr@ti.com, LiangCheng Wang <zaq14760@gmail.com>
Subject: Re: [PATCH v2 00/14] Add DRM driver for Solomon SSD16xx e-paper
 display controllers
Date: Fri,  2 Oct 2026 16:56:39 +0800
Message-ID: <20261002085639.109873-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Devarsh,

Setup: Raspberry Pi 5, rpi-7.2.y with your patches 01-12/14 cherry-picked
and the panel entry added locally, SPI0 CE0 at 5 and 20 MHz, DC/RST/BUSY
on GPIO5/6/26, CONFIG_DRM_SSD16XX=y, drm.debug=0x02, no compositor.

Bring-up is clean: it probes, the connector comes up at 800x480, and
reset/BUSY and runtime PM all work.  The three issues I reported on
31 July [1] are all gone - the mirroring is fixed by 11/14 [2], rotation
180 draws, and refresh_mode takes effect.

All four DT rotation values work, and so do the plane properties -
refresh_mode, color_mode, clear_on_init/close/disable and
refresh_mode_init.  SPI is fine at both 5 and 20 MHz.

Tested-by: LiangCheng Wang <zaq14760@gmail.com>

[1] https://lore.kernel.org/all/20260731035705.3198816-1-zaq14760@gmail.com/
[2] https://lore.kernel.org/all/20260927182329.4193961-12-devarsht@ti.com/

Regards,
LiangCheng
