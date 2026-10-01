Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CB5CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B9AA10E18A;
	Thu,  1 Oct 2026 11:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aoGqLTqx";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D67AB10E18A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 11:50:24 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48afe625404so287161f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790855423; x=1791460223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FT0Dgt5e18RHtkOZyURX3IzLv5nYyC3WvwY8rFhFXVw=;
 b=aoGqLTqxhWV1W/H6YVrLokmCnpEH4Pdr/Hty3bRgtd79DCUMpWfHectrd15FMV6klC
 YUQMJOSUVHCyHE35CQEKODnuq1Sd1497W884Q61dPSBTJA3SvaIcm8fHzeKq7FwJSJjr
 +AMonRK0N/zRWdXWznKNc26n6fa7M2ZW1CxJ0nO5z3qen+fvFku4giCET3bcdXEMOs6G
 fpkr2QdGlehWWAwGQB6FVPOcu8aa4ivgtJ7OGuWyR270yLv07K6PZHRynwaNitaYuVBT
 yrwQUhIm43dJUwkG7huRoAJTYPrXDj2LlFrkyBd5+9NF9SUemYOPLrjqURBU+fEJXAlx
 cIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790855423; x=1791460223;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FT0Dgt5e18RHtkOZyURX3IzLv5nYyC3WvwY8rFhFXVw=;
 b=XxY68u5eQ1+FgpN0Y223n3p9swlpLEUKbVIdOFFrOIvsJfNi1mfNVQayDd7mf6l36W
 7b/1hSR5tjtHfHeAB4d7b1E1a7JKzIOBap4lX4aKRmEPc/PF6V3eU2oP2d0ySg3yU3z+
 35a78SUgkxNosVTEpvwHGMw4I32F7raX8/EYRJy5YfMht09IpkrdmLSlvRFbotHLQ5Ko
 zhY6T8KW5W+zZLOiJ2cI9tTzoIDeJid0sUSDQx+u+nNOZrz2brRmgAMnc3vu4ZLzXCly
 G6DO9byJ6PGrB7l3A3IFMd+CYn0JFmcl6UTO6tXwqj9xCVAkcCKO2F+LWwbBAjxYPEYR
 052w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwu0u9uDXuql9hti4lsB4kzDF9yUx3OOf9/xSZQerNOHbG0/tzmtIyA8GV+F1Gyv24LempfQv20Ba4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nA0IdLO7lxUfFSHIDhf0lGxklmIdQTx0Iywhmx/TsDM/5O8YpY
 97QQs57Vyi/b8BZK2veRLgFjQd+IrrfANV8yoiIh4WpXKnxfsHjnLASq
X-Gm-Gg: AYBFou0Rqsadhj/Ey+Rdasj+ja/zeilrGnzLCHmriIr9rquiobusLTl13C92FCASGOj
 PpmSrkZcCwBt8KAl3iqw7xnoXBIpzXIeBg2WxT8z1a4kGg0KqPBjaTVC9m8AX8W3HlAG9NTlDmf
 LiRh2aZ0obJOzMsq7O5m764b0tRnsnmJV/vLW3BtAfvWW+FkMEtQYUGyRWtGh9vGr6D168YAmWm
 M+NWbSqjNy993EFzF3AP9xDmfTJm1i1vHftigpICWP9bbnjzngjW6f6VT9+qImJ9W6yJ7mO2pCW
 pEVuNMeRjS9yynBMXEs5HzDAmDC4Soae28NSnLSh2uBXRXqtsElllcC/pY6wkPFx3ShTaeIdhSg
 qBzt8AEoAK52jmsJISY9uHh3igH4zhCw7N0gb83DQnEVZeCt/YWLwjr7L6CT/84FYm9/SPgmWz2
 UIOmgC9pRMLZQQtnC0xl5yvfE9/rMeW9ZvCErt6snByLhgf72S9TB0BJNhFx2HrBllZ7iKRGE5Z
 M+XBfaYKAYgLV4B73HmAUW5XxS+JKSR4uh/pkH4ToyAr3FFKtMJWAZeK6sBRgsOVovHOffHGFKs
 Zg==
X-Received: by 2002:a05:600c:8b6e:b0:4a0:73b:a222 with SMTP id
 5b1f17b1804b1-4a01ab4e548mr75513495e9.0.1790855422802; 
 Thu, 01 Oct 2026 04:50:22 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B894800E6F933EC01173D6E.dsl.pool.telekom.hu.
 [2001:4c4e:1b89:4800:e6f9:33ec:117:3d6e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a023ebe694sm37475235e9.10.2026.10.01.04.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 04:50:22 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Thu,  1 Oct 2026 13:49:58 +0200
Message-ID: <20261001114958.24236-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903185147.49411-1-royalnet026@gmail.com>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
 <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
 <20260819125932.5853-1-royalnet026@gmail.com>
 <82c8b17e-7215-45ea-84d1-9991ba6fb541@kwiboo.se>
 <20260819184807.6665-1-royalnet026@gmail.com>
 <f5241666-9657-4f49-958f-476fd366e408@gmx.com>
 <20260902110432.22069-1-royalnet026@gmail.com>
 <20260903091646.7183-1-royalnet026@gmail.com>
 <2f88072c-6aa3-4294-a35d-722d1c7a405c@email.android.com>
 <20260903185147.49411-1-royalnet026@gmail.com>
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

Hi Hüseyin,

A correction to my two mails of 3 September in this thread, where I
told you that the NPU readback from BL31 was the counter and not the
request. You were right and I was wrong.

The reading stopped at clk_scmi_npu_get_rate() in rk3588_clk.c. The
call goes through plat_scmi_clock_get_rate() in
plat/rockchip/common/scmi/scmi_clock.c, which returns the last
accepted rate (clock->cur_rate) whenever ->get_rate() returns 0. So
"no fallback" was false: a zero in NPUGRF+0x24 comes back as the last
rate the firmware accepted, which at an accepted OPP is the rate asked
for, and that is exactly what I saw, 1000000000 in all 104 samples at
the 1 GHz OPP. The GPU readback on the same BL31 moved (1047 to
1054 MHz), so on the GPU a counter is being read. The TRM lists NPU
GRF 0x24 as NPU_GRF_NPUTOP_CON, but the GPU status word your commit
reads at GPU GRF 0x18 is not in the TRM either, so the offset alone
settles nothing. What I have is the EL1 read of NPU GRF 0x24, 0 in all
20 samples, and this: on 15 September, with the rail pinned at 850 mV,
requests of 800, 900 and 1000 MHz read back exactly 800, 900 and 1000,
although your table programs the same ring length for all three. One
counter cannot return three numbers for one ring at one voltage.

What stands: the CRU selector (CLKSEL_CON74 bit 0) shows the PVTPLL
path, and the inference numbers in those mails and in the v2 cover are
unchanged. What I withdraw: "secure world sees the counter", "the
counter is alive in silicon", "EL3 reports raw measurements" and "the
readback is the counter"; "constant to the MHz", which I offered in
place of "locks", goes with them as a statement about the hardware;
and "the clean telemetry path for rocket DVFS" holds for the GPU and
the CPUs, not for the NPU. The actual NPU PVTPLL frequency is not
measured on my board. I will say the same in the v3 cover. Sorry for
arguing with you about it.

An LLM (Claude) found the fallback and drafted this mail in English;
I read it back in Serbian before sending.

Igor
