Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C8606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=pChEflxN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b1HaBzP2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0263A10FB04;
	Wed, 28 Oct 2026 10:11:41 +0000 (UTC)
Received: from flow-b5-smtp.messagingengine.com
 (flow-b5-smtp.messagingengine.com [202.12.124.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A709D10E609
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 10:11:29 +0000 (UTC)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailflow.stl.internal (Postfix) with ESMTP id 012151301DC3
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 06:11:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 28 Oct 2026 06:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793182287;
 x=1793189487; bh=PwX2l7DQwhc1EiN42vI8HhHIEcNBT4Ba7NmGw7MSolo=; b=
 pChEflxNaTIn1Q06U4R2K6YLC1Mm5avWd+wqNue1MZJTTSh6fUbvf0w847MkLbUy
 fFmgbA54GoI++qN+mZt6e7kqFRY6jUcSwSGhJwGVdvgPRci7wC7iSw39IbKmIBDg
 Y3Bln8cAhYWOwV4tBCurbd6IPo00hqSGPltvzAcRmqGkj0Zjckob9hQrtDA2NZEW
 fgwxuuujP8iKlk4Xr2cESD8C/ycTIRFBAJzVnLd3m6z4slRqMX/2WOFQemGU36s4
 BTpusu2yBLQ7J3s9WHQiFRoy/2FO0Pxsh3lHdSvhzYrjKdJ3g5pstnT+3jtKAHPC
 nzzu4GW1KX5rNYL8D07Tqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793182287; x=
 1793189487; bh=PwX2l7DQwhc1EiN42vI8HhHIEcNBT4Ba7NmGw7MSolo=; b=b
 1HaBzP2Lj9cc8EYGYnxrdlVJ/RFFufuAg6lh7/rR4yklydF1UWo9vxyNE+TQFRdN
 TKnqrWg4lvxSecZ/nusuUrAsqJliQzdBWDNoF8Zy9wsDbBQVvc/cLhRpgZudXsQe
 fEnCZyxyeo7UiDim8UcKPr0a3zW9VuXq0LBVW8519Q4JV4Qd/WiEl2KmWDOf+AYJ
 TQgvQeaQUQ9uNKY9miMQQ5sdpvYZWo469TEWaTqFm/wXL8Kqvplr7XF6QY6Kqf76
 ZJY6iTMcFwZtAQaBumVFcdDQtrFXtyQtOKmA3q6euottFEEgaxeEK2gH9rbAE9Or
 8Xgq0wnkXp11z4y4qJAxw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793182287; d=kroah.com;
 mf=PGdyZWdAa3JvYWguY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:E42D+bw7ke9FUJek6R10ktZ121Yz7aDMXAwp2hzhplkgvE2
 +yFbrZbMK8RjdO+tXDqZQKvs2k7YGdrJ57hy7eq2lkI/YkzNRT1wy1250tHIquaV
 FdM+OTQ9bBxOvldaRlSbq7eiFzMVQEvCyxRX+Gj4uIf4KRFfs9ilHDHZeTRGR/io
 4QdX/HaaKGQJSvT6PBs1D9lNmPOlJRRHnwxkoZQdhWLG8J4KcU5vJn364/dn3BmW
 2ZUT5U44Ppah82zgYdZfv2p4DruL/vAwyYcLu6THdEIZAjws3Sr4zUJ6pxcqb17k
 6q61o2Qm73jyIPETlOE3BNKgqJ5dM+4CRIWAkYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-disposition,content-transfer-encoding,
 content-type,date,feedback-id,from,in-reply-to,message-id,
 mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:SdlbCx/WwWPIYeG2Omf5foQWK6pxguuPtqSJN7Gg9J8=:fIJ+eLprzTB89kLRXhW3xJoTh+PmkUO6luZzkLNiY74=;
X-ME-Sender: <xms:TsrhalU2H6s6CmFC0mo9Pish3o2cG7JQD5pKISpZTDzFRYYvICwiGg>
 <xme:Tsrhaqdzx7UDvo80wunzyiwQu0VW4aPzsRWAdzXsrryHqCX4yH8oNeBq5jOvN_Vyx
 8AUR2ryeHijIzBltfNMlRmor3A5gKwlyAUuxbrnrc25ZbK_5LE>
X-ME-Received: <xmr:Tsrhau9Y9F9fs2iV6X3PzS9vRfUorvcexXXNflRa_Bcaa7dcvFSMmCkqr4-PkaA-VUAdG2ZyAPNFxPJNILgyEhBmMabziJUMLsdCA15A>
X-ME-Proxy-Cause: dmFkZTGiAoHe+ZTg9VS4DGzOZJVQZXq069YDfXN4FAWMZzX0cTphdbUHmVXHgMasuW75lM
 rkmH4qK1YylYy3X3vMziTf0j3G4WKGZ1LZzv6Z1zUxrwiQVfzdqnbKWgCfulC12J9V0LHv
 qcPdFAYB+nwQpm0fOQLkA4pE0WvGQ8VQ/5ouQj695NE662wMBDo4kuJUd7Bi0ynZ7x8thV
 zkZl7yAqZ5PmApHkWyFTgk60tMJ3GFFPEbZtwkRIK9tuiVn/w+6Lwv40xCJv8bldz9TSXh
 HAHQpKXhALMcUhLFOFwuPTpwn0su9zKnxzVFUvca2A2Le20TapqQJBCP9ChiDZPkIcMDj8
 msadEET3RT67/X3W4tT5ymOOM1DzzrZHLtL53LzgthytcsXp4sVWpc+OFYUtc59MiYtTDg
 kC2VXlFRvQvZeOfrXc1TmjH6TZjawD0AmzQwh8Zc1O+Iq49Y5vkPAD2ombYVfsD02aK7xC
 8D1Qz9YBOU/0s6ADoVnFcWTGTfCXRwmOCp+tPMoIxImPWV6q0dmQsWD0nQ5qZsbv7DgLOH
 fcmD3QVwQq/G2TZ9cluKPtxLKtqYgidnr/9wAT1A/kDc6R1HsjtRiU1T/oQW35pqU9hXgG
 AFmvrA7kimhu4dLwkvcgS3dd/rV2A1Vqci7uT+2KOcp136lD3uQ+VQ0KDQzA
X-ME-Proxy: <xmx:TsrhaqZn563ElQWPsg4ymvhpc6Vn5nSIF_-IWf8zonClPyRnKxcBZA>
 <xmx:Tsrhauue9g_LcneG6NlSFE4z1URxd_gaaDyquUbpHkoNZHNenEVAZA>
 <xmx:TsrhanYTl3f2NTDfgCPjhFxeMDFUQjeO30t0FMLM2kdn-EQqx5hNXA>
 <xmx:TsrhaiSNVDQx797pT2vHpCQrSEwb6ssPHIuLpn23o0inmVCa-okOLg>
 <xmx:T8rhaob8Y6NKPG4PiEhGj_2pleZc1LrAmXidktuTtOeNL9rG-gsd-GpP>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 06:11:26 -0400 (EDT)
Date: Wed, 28 Oct 2026 11:11:24 +0100
From: Greg KH <greg@kroah.com>
To: =?utf-8?B?5r2Y54Wc5p2t?= <panyuhang@hdu.edu.cn>
Cc: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 security@kernel.org
Subject: Re: NULL TTM backing in the PRIME import callback
Message-ID: <2026102854-spry-unhidden-7b28@gregkh>
References: <ANIAPQCBLHZReocA2eIWZ4rb.1.1793179941502.Hmail.242270054@hdu.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ANIAPQCBLHZReocA2eIWZ4rb.1.1793179941502.Hmail.242270054@hdu.edu.cn>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 05:32:21PM +0800, 潘煜杭 wrote:
> 
> 
> Hello,
> 
> GPT-6-Luna assisted with the initial analysis and drafting the proposed fix.
> I am responsible for this report.

Great, then please turn this into a patch that can be applied as you
sent this in public and it would probably be good to get it resolved.

thanks,

greg k-h
