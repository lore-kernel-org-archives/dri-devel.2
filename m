Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341B2C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B59489F1B;
	Fri,  4 Sep 2026 11:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="eJgJktwj";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VaKpTkTF";
	dkim-atps=neutral
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1EA89F1B
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:19:07 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id A2F691D0013C;
 Fri,  4 Sep 2026 07:19:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 07:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1788520746; x=1788607146; bh=8AAYthSm13LQPXMSgW2GQbce5z7ohnwk
 vamcvDYvS+E=; b=eJgJktwjhYHCq9zZ9Jr5QicQjmUh1566Jn5lZQw8zMWsNJVs
 aZhg9MuEWjH6nwxPk5cyGTwZR8M9Yd+oUmlBxUDo9cVr+XQLPnf4d7FrIUggHZt6
 pOsRN4fll2smXHqc9mIa1qpppWCUi450EO715zlew2v9LS8cw6Sx3rWK3wUx6xGY
 3y9ich5qWctKnBu7mlfn5HCqYNeYbdH9iVtmM+gGgjD9AUr3Klo01Xq0kSh0buU/
 f9c4Ly2EulEtkGPDy57yP9FlFnUotJcEWJP942O6xFxroNFGl65lVn0o3yt9lUfO
 M4DTkkGgYTUYhQvtSC85VR/1Jnrq7CtMb0ehZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788520746; x=
 1788607146; bh=8AAYthSm13LQPXMSgW2GQbce5z7ohnwkvamcvDYvS+E=; b=V
 aKpTkTF4HXQZbpo0Yntn4pMhwdpJdjJUGRQpc4azrneouEt+vhfKf9LJTcw6h90I
 xR4UlyCFADR6tILUKLp8mynROeRqqxPmGZTHLVMbKHeU5Y8YSsWsC+ND5YmAutpn
 XVbAW7t6Bq87JpGQdeQxfii7EilBY15wtBEmgOGJnXCUFARtXd25h96y3GVArEwg
 DSp6Nr6EBcXVlMiaFXuwsaokzp1wr5p9ZrBDoJBccgBZNYOtv8HpG4h9u8Ej5h4N
 nhfoVcM/blpcS1U47OwkmMrlXMcv5Go6GjBV8UkADCmHnwQfvOZu3cDW1lsX/8tf
 51NOy2F8zkwZNX+m9pnnw==
X-ME-Sender: <xms:Kqmaaqisw5YD_diULFPm-prGp0TelO-QzomlH7TGE9hThd-p7bkrZg>
 <xme:KqmaakXjPL0jhsfsseF5sbUZhrwlw6eWYQNs_3_wyKwZS9S_NMi8sAvv1WZGlG5Hm
 K8XPxsPqCVGOJ-a6VFlKhe4gd-mTer71O42dLvb8f8VzGrQumMK6yIZjA>
X-ME-Received: <xmr:KqmaapWRLgdo6GcXv7pOdGws-1nSu59EdN-iG9kHBchK0i9CgHZZVv2WawWJodYGlhFJEVw58w>
X-ME-Proxy-Cause: dmFkZTFLErxoBSq4Tt2+IoBW/VXnEsgz+NZYPLmhdFK783CCZjSAM69T2b5AUHoRCKk53L
 418PprOKdsIiSIx963JVHH8SVuGwasB8N/3/QLBo5uRA2J0Ld4PUnCrIrnwI+RpsQwrP8p
 CFdszgEuTsh/odcNFKDujhfONMekScFmmpNgIFM6jXNv0tmtt9UKZkAtziP8k/QI3TVYK6
 poYFcf50URYtjcwEGrFXgOYtZyDd/WRY1ExAPngduT0CxPMl4T56fgIwBlplL7UVkjXAl9
 rZa4VLUNzr/NY3bDyarLlJEoQLQe4u1iBLETBmFQl6nYx0JZSpT74Hx3vJ4l3dH+LiIOcD
 16kD3fHd6Y0Hp+C/aPfMHqF0kzpBwD+vQWgo6bj7ka/Nm93LWprUyNzYq36AVAdw522CSU
 n+/JspujOl3LdSzYpgsMgy0wbWH6x4NX86MkzrdjN7elucrJ9dCDNtdWLoVxSYkmlaj5Ze
 iK+Zj206CMYJPpB0T4U9GZU6kqn8+tOhbeOX+oAAA2loBVQcDJv85hG0bJS5J9mLmaHCsV
 DaC3n75jgbktz1DIR9kxE8BTA7b41Grm8GGc2wBJ8kbMR75hPoBcgqM8pb8Aq2ALJ1iJxb
 oxglesopD9UePIPK4ciTH+9lbqfzwpcVjOyO9uElvecfSSksfIEQ2JnLT+Pg
X-ME-Proxy: <xmx:Kqmaakj5K-CoBz7zZGGBKs3wGAZQRC5U6LG1MmP1T2zFP4uK4N_Rog>
 <xmx:KqmaakZKGEGy69dc-ym4GZDvKYvCm8xcDiVt8CSMY-QO7L9wgju2-g>
 <xmx:KqmaahqIaLVCWho3yHMu_PM7cNXrnTvEykN6IoPAR_QOLU9l3e8SYA>
 <xmx:KqmaahMrBRfInXVUn-7H-sCWhjPDi0chQB3VLl24BA06PlBlKaUR2w>
 <xmx:Kqmaar5DaKISOhVsjz9EWbx2kZrUh-F1RfJ_UJGQtbXmWOyOywS-rn_L>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 07:19:04 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: nicolas@ndufresne.ca
Cc: royalnet026@gmail.com, tomeu@tomeuvizoso.net,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Fri,  4 Sep 2026 23:19:02 +1200
Message-ID: <20260904111902.87135-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi Nicolas,

> In the DTS, I've removed the assigned clock/freq, to me keeping it
> would be toward forward compatibility, and is fine, but I don't
> always fully grasp all the subtil trap of DT compatibility

A data point from RK3576, where one clock feeds both NPU cores and the
convolution buffer they share.

With no assigned rate the block comes up at 786.432 MHz, and no board
sets vdd_npu_s0, so it runs on whatever the PMIC boots with: 750 mV
here, where Rockchip's own table asks 800 mV of its 800 MHz step. One
core is exact there. Two cores with jobs in flight at the same time
write single words wrong. A pass is 5400 rows of a batched matrix
multiply, each row against the same multiply done one row at a time:

  786 MHz, 750 mV    11 to 25 wrong rows a pass
  594 MHz, 750 mV    0, 0, 0, 0
  786 MHz, 800 mV    0, 0, 0, 0
  786 MHz, 850 mV    0, 0, 0, 0

So the assigned rate is load bearing until something else carries the
rail. If your OPP table carries it, dropping the rate is better than
keeping it. If the driver may also run with no OPP table, which is
what you say it should do, then the DTS still needs a rate that is
correct at the voltage the board boots with.

Does that hold on RK3588, where the three cores share one clock too?

Cheers,
Jiaxing
