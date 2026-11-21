Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C05606A325
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KalnYlvh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A1B10E93F;
	Sat, 21 Nov 2026 01:17:59 +0000 (UTC)
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com
 [203.205.221.240])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0797F10E8F8;
 Sat, 21 Nov 2026 01:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795223869; bh=oshmEbhTuynSPdprXheSX46+W/4EBgnuyXBHhklZIpo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=KalnYlvh8TrKiI5IxwpAPSFrmUo/22pB0AUy7WxrYWXPqBpfURlZ9ZUU61JzMgPhV
 4TrFaBr+r+YyBVvyw4Lpd1Sea0Dqd8DpGAE5Vh4KGVvt0L0a3vTJ/C5nv/mZvZ0SPg
 5IKNddgz5DXvhHLDwJ2pmcUWBRyDBpXyKkeIdys8=
Received: from [10.76.233.111] ([240e:428:9036:8f29:1e93:bf28:ec2b:23ee])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 46F9BA8B; Sat, 21 Nov 2026 09:17:47 +0800
X-QQ-mid: xmsmtpt1795223867topbkop4l
Message-ID: <tencent_D0C1DE0896324900E96F2669116ACFDD7708@qq.com>
X-QQ-XMAILINFO: Oe8iJ2SlZYdbNrWextFZDeyx635bl78rdcjiKRQ5SC8PYja5//aOqYkspV8gN8
 Ih0wetYCbkBsIGhKXmfhGT5KECt8BnZ29E/hMQakU70/lO9BYkRR6idTXs6lI54jHU+tRRCB4wy8
 2oHAX5E51X1Bn79mKA1UsTHF8kTK7dAYeJCZOWVpfbBROI1pd78Vetl55N/Rk2noW8dP+C6dv8KV
 hK/Bc+s0kW3OY8U4PMl2rytfZhY9K0BQBq0i/Bu96wjHPLmWH1LNtXWgzXbk2dkQ7LBUAAvSna46
 pd/VMFVIrgMOuedzYMRjSowDooe9thiVylYZUMxKCtZYFJOKq0W/D2qV0AVOgdGwT/GsQL/pYng8
 6ko1bmA9ozTXDoH/wtJgDrneRdv6FZ1xYT/JZk3ST6NRFSgIY6cy+x1fnus9hmevi2x+Fh8TDXdZ
 FUiiQrI+uBQpIntTDFdkrXgG1/cakF1SqKgRU7qaZTYx5Pc0CWt+rTOVI+4iiv796TCV0/5hzcoL
 e0EAoD4fgEUmBZ0Nr+d68KYevT2Hn5/mOFB0Va+FScgVwZDFb3j3Cb10Bun25HVLRMq0orKYbutU
 xytxtwV1IwTqBy1Fy7PZj/WyHho/0whAUVMIWI3vwlNWGWdSCl6Fav+A3K5KFiTZ99BM2d3+X0pX
 IpHv8EUnn76VNPTJGg57lDicZ6PnL2yUGItv8EL0aD0i7gx9BsrbgEhh1CoYNoVUKJItWQHx6mXK
 48dTBF7m9n6b2VHLH4xPfp6CM+BjVva/ly6PeZc6jzmf52oliSUQCznpofXFNaIHVDgsxGVRaxsr
 u1Qj9OPwlVSJETR7ZtWuaSUWuA0c51dqEdUR2BT9OBDYya/jwB9Q+le7OSYaHIRavR4gr67eaiot
 yb3JJ5XqCUQuNfkhfYItfUE4gkEYXY6X55te0YyEHwM6bLIQB9CjLW2xmo+n2htsERT0YbbuVnbV
 ymJmLcW64mZSdGunG4ykLT9BFxEUrm3eakaA4IwtUPTeyGOJhuj8ZsXtlSz9QswvMq6mhT4Kz4I6
 /4eRjg48gBqUgo+qhSMsS9HOHe9dQ2gqy2KMYwHLI0ehtUZbBKiEBO+0bqSktWfmNQlz4WYw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Yitian Shao <fighters390@qq.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 jani.nikula@intel.com, sebastian.wick@redhat.com, uma.shankar@intel.com,
 suraj.kandpal@intel.com
Subject: Re: [PATCH v3 0/4] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP
In-Reply-To: <20261121005409.17626-1-fighters390@qq.com>
References: <20261121005409.17626-1-fighters390@qq.com>
Date: Sat, 21 Nov 2026 01:17:47 -0000
X-OQ-MSGID: <179522386739.13169.7346052031345257632@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Runtime-tested v3 on the same CometLake-U machine (kernel 7.0.0-44):

- HDR_OUTPUT_METADATA is attached to eDP-1
- the DP Colorspace property switches to BT2020_RGB with eotf PQ
- a 4K HDR10 HEVC file plays with VA-API and the output stays in BT2020/PQ
  for the whole playback
- no state checker warnings in dmesg

As before, Mutter sends all-zero mastering metadata, so the effect of
max_cll/max_fall reaching the TCON cannot be observed visually.

Thanks,
Yitian

