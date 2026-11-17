Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F93606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g/U+A7sV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07BAD10F6D8;
	Tue, 17 Nov 2026 12:57:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C912E10F6D8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:57:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 081A763489;
 Tue, 17 Nov 2026 12:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621901F000CA;
 Tue, 17 Nov 2026 12:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794920260;
 bh=ayQX72Nthi45ceW7BH28qruuX+qLax3sWs6E3u3jR3I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g/U+A7sVehbCN3t2ROWsGG8VZtSwhHoPYxtxMkZa/jmFugkuRPcAu7FWmd2RyOW16
 nSzdxFB49HVcj0PV+BL/6ybadeTuio5KbRcxWJK4mqxJeozaxlKKoGNDOLtK6NNMxV
 FvIOhSGTmH2bCjViQigBS9UzqhjhPRbITjUECbI8BUNInBOhP16C8HK2hgvWoswHfn
 ORNVDx8AVS10OiT7AMvz+wuTErV7O44f5n06AfUxldU0Yj4M0yODdXlUb3PJgHMa/y
 hQddk0n8UceQHOsMGsS891E2FxYcnvN7RDO8HF59+CNQQCaCPQAENv3W+1ltgkuodF
 djn658XlJ/23w==
Message-ID: <sashiko-outbox-218814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/11] arm64: dts: qcom: sm8250-lge-timelm: add
 reserved memory regions
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-4-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-4-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 12:57:40 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] arm64: dts: qcom: Signed-off-by and Author use handle instead
  of real name
- [Medium] arm64: dts: qcom: sm8250-lge-timelm: ramoops sub-buffers
  leave 0 bytes for dmesg
- [Low] arm64: dts: qcom: sm8250-lge-timelm: changelog omits
  cont_splash_mem and ramoops
- [Low] arm64: dts: qcom: sm8250-lge-timelm: reserved-memory nodes not
  sorted by address
--

commit d0da8e8448ef005db2a8bdee2ccfef831c824926
Author: rofikkerneldev <rofikcoga@gmail.com>

> arm64: dts: qcom: sm8250-lge-timelm: add reserved memory regions
>
> Reserve the XBL/UEFI log and DFPS data regions used by the firmware.
> Keep these regions protected from kernel reuse.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The Author header, Signed-off-by trailer, and file copyright header in
sm8250-lge-timelm.dts use the handle "rofikkerneldev" instead of a real
human name, which does not meet the Developer's Certificate of Origin
requirements in Documentation/process/submitting-patches.rst.

> diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/=
boot/dts/qcom/sm8250-lge-timelm.dts
> index 74b673ebbeb9d..ecbff27976fc2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
> @@ -103,6 +103,12 @@ ramoops: ramoops@b0000000 {
>  			console-size =3D <0x40000>;
>  			ftrace-size =3D <0x40000>;
>  			pmsg-size =3D <0x200000>;
> +			no-map;
> +		};

[Severity: Medium]
Does ramoops@b0000000 leave any space for record-size =3D <0x1000>?

The node sets reg =3D <0x0 0xb0000000 0x0 0x280000>, and console-size
(0x40000), ftrace-size (0x40000), and pmsg-size (0x200000) already sum to
the full 0x280000 bytes. In ramoops_probe(), dump_mem_sz is computed as
cxt->size - cxt->console_size - cxt->ftrace_size - cxt->pmsg_size, which
evaluates to 0 and causes ramoops_init_przs() to skip registering dmesg
crash dump zones (PSTORE_FLAGS_DMESG).

> +
> +		res_xbl_uefi_log_region: memory@80880000 {
> +			reg =3D <0x0 0x80880000 0x0 0x14000>;
> +			no-map;
>  		};
> =20
>  		adsp_mem: memory@8a100000 {

[Severity: Low]
This isn't a bug, but ramoops@b0000000 is placed ahead of memory@80880000
and the other lower-addressed child nodes under /reserved-memory instead
of being sorted in ascending unit-address order.

> @@ -119,6 +125,16 @@ cdsp_secure_heap: memory@8c700000 {
>  			reg =3D <0x0 0x8c700000 0x0 0x4600000>;
>  			no-map;
>  		};
> +
> +		cont_splash_mem: memory@9c000000 {
> +			reg =3D <0x0 0x9c000000 0x0 0x1200000>;
> +			no-map;
> +		};
> +
> +		dfps_data_mem: memory@9e300000 {
> +			reg =3D <0x0 0x9e300000 0x0 0x100000>;
> +			no-map;
> +		};
>  	};
> =20
>  	vph_pwr: vph-pwr-regulator {

[Severity: Low]
The commit message mentions only the XBL/UEFI log and DFPS data regions,
omitting the addition of cont_splash_mem: memory@9c000000 and the no-map
property on ramoops@b0000000. In addition, both /chosen/framebuffer@9c000000
and ramoops@b0000000 were introduced in the preceding commit "arm64: dts:
qcom: add LG V60 ThinQ 5G (timelm) support", so folding these reservations
(and referencing &cont_splash_mem from framebuffer@9c000000) into the
initial board commit would avoid leaving the framebuffer unreserved across
commits in the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D3
