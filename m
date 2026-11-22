Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E0606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=d+xMg5xX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E8010E701;
	Mon, 23 Nov 2026 08:19:33 +0000 (UTC)
Received: from sonic308-20.consmr.mail.sg3.yahoo.com
 (sonic308-20.consmr.mail.sg3.yahoo.com [106.10.241.210])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E9510E62D
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 19:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1795375748; bh=9bKfAWcfi3fcLmMSzFA32EaHtSL2wjxQDRuqCwiDgvU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:Subject:Reply-To:Content-Type;
 b=d+xMg5xXDzLDoq+fv27ILki/YiEyWVydKhtXm+LLTkqkH7JDk8NNEQ+poM5fkaM9H3+twAAe05muE07GDRoVFM+cfuHaLzyavq0FGv5R6XK+QrwDLjdbMXTRzHm6tP3BsYM2LX+XJNv2UawHmuQ5RXT7/wpyPhv5Bnd4j100foaqsndjZbMP0Rsln8JoM64d/64qCZpA9+o8NKSctSkL6LdHBhDb5pN33QJOzS07SVOv4gmPnLjSTWGdqAX2OTmKu53rXmy39es6SvtDevrXobau5qgN0AKxEGGeTbHVff/GBF7Re5CckH0ULn2lVzLmPQ1J5Sp19ykh954iy/3sDw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1795375748; bh=UaeeY3MR4qc3m3TxuZr+/a+X7doxDgYuVi2OQ7/39qj=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=jmTQjBRfDXGgnTNfaXAoNh3NG80/M3M+Tv3++a3fipUhTZE8luIVOj2CkblOLtJBT9/7H5geiZDqVl7gzwq71L6vc7dWrxjSSQo1Fwbshp1ku4oYiBxkaZeSXhXav3j8k3ftNyCyWwN0jZL3nOPQKvPOE6iluNFcTQ4OkO7D8nEq61hBXZs2QOdTHv+B7SVFuRxv6wnHbiC22kekEuu5eqVlxNhOD8r847K6IWXYJYyVjcrxigLOq7MMmIh3wflsMZQjSqvUogxcgqV1BLrC02S9I198k2AaiwRMMWmjoKeRqCWo6VkvandukQf2LspzCoP9T0yARjuRpTDpJR9keQ==
X-YMail-OSG: LH1xPCkVM1nPiCXt2DJAijST0SFJBjFnbsUAcUEU_5ODiBRmzkZ7FajlS1kZFe3
 6QQvwKTnAcs0rWVLEk9JL6Y1ufu_vYYpxPVLwX1IMnf8c_KgItOYZsyTDFOBNsTC3deOXJLQC6A_
 ja5GZP5yaNxuoiS3IV4GzHOfUITI67GCNpkP9s7YGNg_NBlaiXWkQCCe3whk_fObgePHDptZWQ1x
 IfNEXH_P3KKSdEO7c0ZMTYiQjsfNdW0yEZdt8Cyn9NOBHYyyCKr7EkG1WIoizKaFBvDkYuGaHQDa
 FrIR4jOrwFF.IXmZrMU3qXsfeThFAoPxWwWOVLeVKGup7qsE1F8yhQ1J2U1_zwmLiElnSrvGJwbu
 97rt0sKoeCPutviQQJ7S1YCmkLc7lZceOIB8conYQJNC1y6BNFQWkT0HX7gj_fHuMxOvTkv01LN5
 rUNeA3sZN.P0dTfcRhK6SszWwRjYI5tCeS_FEeVevcq9RW89an_iBkVuefnpYc.VWS7RzkV8scCQ
 MOkLLco_hHPn9rJmgHSOjUEgQjsZhcqChDqUPHMMdL3EwcfvG1bDcbTVthFx7fnKp5.a.BGg4lFu
 3WdXGQbys.MimfbkcjgSdbLY6ZFTimk4JH3EwNafwFkhqmLYFaSvcO2BvKqGmcO5CWIUHtublhmD
 vdxS78F6mqwwCI79S3augQzgf3mYmSsKGx6xrfszaLRnCnR9jj_9pTl.xveaRu26uO08kVWw1DBe
 56Ygc1ZFqFbOavbpocagwtknVMK2pScL3d5mtaZKj0zs6_JBw7gWkKJmch.56JoCtdKiS5Opx.jJ
 c8zfZgOvDQQvR8wrvuTJsIJ4l6Fob1twv2dLexv0VdjaKB2xCDgWzMUyxb2nEOXDN59eKEnmn6hU
 60pqv61F_3L5JZJyJxVTg.QhtbLpnP9v6tgQqHLDb2XIm7Xkxz4ju2afnhBOibqIQhkhdod3O6Jh
 nYtXffzIhQQxZpN9s7OqcdfT.DgoGXOTIrUsdhni.vAK8xXf4RUrIkX7UsQUhf7_kyLotKfM6f6R
 SmVu9PPZzBLAUxggByugZdML5dH9D6yqIT1C_ll19y6p42ZBy_rYUOm1UjSgsxKTLvllJCwbifOQ
 hEuItP69WJsiaEuXsEFnZXX3jk.QokBRiInWLG6PHdboktuVbU_nUJFAx2prruoVxajZNQrDYNV.
 VMuxy3kxqWSh9bU81B6aNeTPyNVJ7pkZ8ITNWzVjVxHy8lUhKZSJ9duaZ0k_v5jLR7cwJFSKzy6Z
 sWO8uCtZxLMhuEgOcXPyelFn1dxLZyuryu3njBCS3Xi2b1wQL5hRYqwSKX.Di0.1JzPzYBLfaMFs
 2A2L7Y8PdvU_BoSX5ZlPL6CMkkIkbFXASf9Q8D8UB0kGwmZk_G8Ek2orxVghVx_zYKmNnS0.LUQN
 TgLTTkJ0MlHzU9Qrf6mnuWJ6nn1RUVQsTFkwd6E2bMH2.5_2rqTbqzSuGVhHQXeEvJCDEUQWUGd9
 fH_LsQqMpSrgIuQgxU5DqoHZh8Q5_wM2CTv3esotBYn5Rgz7Hd.G2NRHSA0YeoQ9PV6zu9yLDjaw
 1E4My78IHFj4gKUBgrirhz6kSydaWfsgyRJxroKHF48Ab0Hz.TfjPX30IHdeZ7bSjjAIKJIDhcQB
 XinUQObpW4ocCuFyIiDnrLUS7Rl1rCoOP8PzVwkjvXnQBTRLxnuyY0a9r0LAAonxRizvAguAImaL
 .4PwttmUM0dkGhId_Syf9H5DY_osdC6C.pmEuLYWZ71XO6PSF2s0KTm6lHfGbyl5vFP0AxZC4lu5
 tGTTS9c58dn7MnJbBNyvDBcNsV57yi.mr2_5ryYh.otJ3Tlv7Ca1aNdIcEpZHgW01mbiCBvXulUC
 wUMPP2qJn5.flJWFz3nuu1ebdKgA6zrilMunyPc6bXo.ENmT_SIe4IVGeT_EP7NYRWIaO8y0N82O
 7o6Yxny3ezEF3gefj48Z_Wm6dsr1o7Hw6eTSdg5ag19PESXGIo6YAqWxr3NPsBum0HoOU3YR7VyD
 pJuu2XlKRafULrSOlKNp7VL28h69CTDi8ACp_mbf_8m7veIFSdg0nHWefuqC0kt_QyT760Km4JnM
 .GbRaZVmw1DRkNh1AlwVi2RVmLpx75lP3hsND6E_UCoDxEV.CP_5sUOjVbc3oKd.uVQJq6TkkM6t
 8Oy8B9ctfTh1I7UHX4SNs9Iec1sWqdcNHE4U5OvwvmHVNddUiZgph1obM1ykwKRKjAyV1go9kSXD
 d5LAIPl6SQij2BHWHS.MRgJe92TA3x5G4VlSjqEwsNrJp51Ri
X-Sonic-MF: <venkat.yadlapati@yahoo.com>
X-Sonic-ID: 3bb82e72-e795-4ecd-b31e-ab47782c8089
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.sg3.yahoo.com with HTTP; Sun, 22 Nov 2026 19:29:08 +0000
Received: by hermes--production-sg3-5ff9d6888d-8v9g8 (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 0054f2a6f4ae764e46fce762305b29ff; 
 Sun, 22 Nov 2026 19:29:06 +0000 (UTC)
From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>, Val Packett <val@packett.cool>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH] drm/msm/dsi/phy: power up the digital top before starting
 the 7nm PLL
Date: Mon, 23 Nov 2026 00:58:58 +0530
Message-ID: <20261122192858.3550896-1-venkat.yadlapati@yahoo.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20260924-dsi-7nm-pll-digtop-v1-1-c2b24c8e218d@oss.qualcomm.com>
References: <20260924-dsi-7nm-pll-digtop-v1-1-c2b24c8e218d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 08:19:18 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Sep 24, 2026 at 03:51:03AM +0300, Dmitry Baryshkov wrote:
> dsi_pll_7nm_vco_prepare() de-asserts PLL_SHUTDOWNB and starts the PLL,
> but leaves the PHY digital top powered down; only dsi_7nm_phy_enable()
> sets DIGTOP_PWRDN_B.  The PLL cannot lock in that state.

The same lock failure shows up on Molokai (SM8845, derived from
Kaanapali) in the Motorola Signature, whose panel is on DSI1, but there
it is reached through a different path than of_clk_set_defaults():
msm_mdss resets MDSS at probe, which leaves the DSI1 PHY powered down,
while the dispcc byte1/pclk1 source muxes (not reset) still select the
DSI1 PLL. They are orphans until the PHY registers its clocks;
clk_core_reparent_orphans() then reparents them, and since the
Kaanapali dispcc driver, which Molokai uses, marks them
CLK_OPS_PARENT_ENABLE, __clk_set_parent_before() prepares and enables
the unpowered PLL:

  DSI PLL(1) lock failed, status=0x00000000
  PLL(1) lock failed
  dsi1_phy_pll_out_dsiclk already disabled
  WARNING: drivers/clk/clk.c:1259 at clk_core_disable+0xb8/0x220
  dsi1_phy_pll_out_dsiclk already unprepared
  WARNING: drivers/clk/clk.c:1119 at clk_core_unprepare+0xe4/0x254
   ...
   dsi_phy_driver_probe+0x334/0x364

On next-20261113 without clk_ignore_unused that is 12 lock failures and
12 WARNs per boot. With this patch applied there are none, on three
boots. The panel (DSC command mode) comes up as before, and the
brightness, a blank/unblank cycle and Phosh all keep working.

Tested-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com> # Motorola Signature (Molokai, SM8845)

I have no HDMI output to check the SM8350 HDK regression you mentioned.
