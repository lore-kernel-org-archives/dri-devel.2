Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC251606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.fr header.i=@yahoo.fr header.a=rsa-sha256 header.s=s2048 header.b=aiC3XRFf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9930A10ECF1;
	Sat, 14 Nov 2026 16:24:48 +0000 (UTC)
Received: from sonic313-20.consmr.mail.ir2.yahoo.com
 (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8D210E79D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.fr; s=s2048;
 t=1794574824; bh=Kp7knWh9ofl45N6b1gti1nExdA8H/UwtkNHp3rQFPMo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:Subject:Reply-To:Content-Type;
 b=aiC3XRFf9F6JHrqJXIY5bjaoP0WrAgO/vZIPhlmNvSy/NUXprQvmAnS6JGd3ZNdrdd/7xYDTDX06HMvztED5vQEXdBVSSFsO366DMAUwiyKxy0xVqmOPBmgUK1dYoG9YUIoYAI+IMhh9Vs23Fc6RyZ6PkG20dp/R/Aau4wDB0lc3wChMonHgcIvMYbhF3kPmHUxiuGSS5llihXgMVUT2b9gJ3VyObrul24iIeH9sle45yNTHrzHWk2Mq5U0JScIvcvyJn0CL3KVwKIFGiIcxfRkYK7//+WedpVf5+nUpMBk5ptROY2I+ZNTOTm9R/7794xN96593VAeAW2GA0FLNCg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794574824; bh=gvuM0yqY9fAPeo65eBSE77zhITR6gfJEH8ACXEZsyhe=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=ji3V4YA9B38WQz4QSNX4W8kPu77xOoV+tUJiw15piUFOwBKLNoMoS+iCWxzzQlgBAN46Br9xTYkx49T9Tcn2bWSFdURdmHtVezLHf/7g3gNh1ibl6NxClaYQ7upCQo+v3pM0SFFVQJ5OsNrQGAMmwQzChkycSBtPgvCvAoVSdv4/HC2nhHvrnqtONKGx0Da4wzuZ2//bbP/MIY28zgaw82pso5rx31bZSEW/IHbLkB94GT6CsLcbB+HJffL/aGnYagak9VTLU3QsgqFIjnSYLe6udGh8byrGc1MwZSjwV1KFmrisfPduxxtoDTIXjR47c9yHQC8kLeGgRAhtMaT3Ow==
X-YMail-OSG: zZGpyCoVM1ks8QXfpO.to6W.e0d4657Oj1NQTp2oq3WmUBHaWjK.td2b9uCC37e
 XI4OO1WpzRLHUkVBJaYT4quEUMMV9W6bZ0ZFFtRy6SSz19ZEtFspU0SN6zJKqpVemcq0jR7HW2NK
 GMgxF69_7Dzjn4NF1MIUisb0Cu3ENzsqUNTVPG7x797w4WW9IVgE8fxmHmfVdyY5ur9pWQO3YWCu
 Y7choIt_.b34_lMS6wpDVSBzPlEB9miHRbWrAfs_S2ad2_g8CeFAxSyOvtSUw9OIcPVdbFXXBysL
 OeSl4vVSvl02lj95iMq36fxgI_bBa9yqmhq15ZFsR7apDYHoKg5fefC9FErea0BPs0Tt3zXzkXKt
 mkuDHA.tRpu3K7KC9hbKR0v6Xu6U.glAEktIe9e2Tqwyxw1s8epdqhOgK9k58_aD4hlib5qD9Y0o
 ur9sBWLrm8kNpBVPrQts3WlRp69_MdPkUj8PD21phMSZAOehz8DirjjFUO3UWYeIRIA4Qd2zZ3sZ
 2UNtiiS3LZWVdbWO_Vlrmlio3gHglNvohIfsp2Pl3PnU.d7up2L0qOwRgs3rcP0g0gVPDbKyyXKQ
 iXoKk.VIK36D01Szz6Ne4odq6iti2roJluuHgCyqt.Ld_ffcDIvxMLKab3vNIXaZgvb8ZVXIF1aK
 KqAaB2fQJMGk6DrmmROmB2g6FnZBqZgAfpYQLHOpuOPsf4H_3.trrTRvFLPMyXREqPikDRcHUQFE
 OpPOSRrWLOWrbTLytZ7nM1IgoQBi2APWLh2_jwPMjB_aUmFIR79fkl7jKYlSu4MKS5o_2Zbl9dwz
 aD6mopLc_GyezST7eB1Brfbdmh57hf_afZDlHtQSAswqpAx7JjTbe23BmmMX7iRwHupC6VlPdHV9
 IoXOxDukouNDCg.f9HN22lDpcoVD86t2InKongLF9nvyGj0M4DGDfLlY2IS8iC8v28wvvtyRkGUK
 i0k9PLaOnl.GQ5ICzV281hiN6xuVPdVW7QTZe88nuC3BHkKUGAdPpaCRtb_FtCRM9mL6m5Srcqm7
 AqGjPsxOZksQfcpaowT8fOhOkwM8hWhyXrQj_NZJL_DoAhpn_4X1nA7Qi6uPG0Jxh.33qhcjrluo
 5_tJVY.Bz39LRhkZJ3hpn.un4fTD..ezRE0KKMyTEx9HGcoR5gkaa_nQIbWRFMMm7iF9hdQiAIbn
 ia0ufocr1KIWfCUHCh8_ppmUU6zDHCpVme0bIwUfYry6ZRIQrEiCDfHsKvdKQXLNVk0z2Kj5jb3c
 SHeCG5tdIkKKczWF7NhdIqKL2hPJs4CzQ3htDFGZXo9vfZjHwECy.ITZHfMg_CfeunMENAWC8f48
 M3qdTjZLhE4ReJxlEtG02iL8e6Ecb_5XcfSwp8PeRql8zGpZv.VEDZpn7d5bsuHQjTO1.dohfvY.
 67WnDNFSp.dJLW.ozZPpb4sf3N3sLqq_k77BeEr44G52sX1geBX5saCsW8rRZm7tNfjbY2vdFVSf
 QjHHSHhpXHY7C8UGpXtGAWirYYkx3RkmiNozo1heAV4prB1oKGh_Qai6kGdnqp_r1DLxh5pbaxUx
 FXLJW1v37ZxDoe1VttOLnXwE1mvWMgfHHDiCi2ESQybW0.ToZxasjno9.iWprUwQG4HqXL8YVPpz
 g.ukxFXcr2_K9IhkVcfQkAhieZBJwCSoMossH9bDWEtWJWXBEr2kb5wsOjMYuYTtT4tm4hFhIkwB
 iDYuSte7IV.UbZRVlrol3hWW4dok0stLtYKKv17syzfyctYxK0SkQ90XufufTcgyVKDOXWevGgQA
 m4z_YvgCcsAR9wCBkwO6x_XJLtE_lGLOEhvGNOLAKgkTDTnizLnn3A03IHCCIiKkp.ccs0lm26QO
 oBx_6rgnJLiPVtUJ6lg.55eq0ymBED8sOArl57CqOpMvp3.Oi6CgcpIrWicWftkUuad6m95Trt6D
 wudct.gvSmEspkQ3MtE7OvCd18Jf5vw1ZQFkLAzm1qYiY_4rV_o4i.RmaxCx7eA.CImcXYo9D7t2
 o2SH4qHPpUUpEkm3MYEAXkcAjfK6L1iXHjIAr6jrSub3e2HxGkjj8N6ptsLauow9yZB2WyJPFI8S
 1_ecl0JZkges9_rIalIPvxihVHonGPAoLiNMWpnj28QNgydTGSjfG5eSmrSWEpCGIhcVp5cTksMN
 _IAz8lBKnrfNrMjfSTRdL.HSYY9QQpxnbYB4DirEGF1iydqJQuPH6NwFn0ykVmWE.Qh1eexzx8Fi
 refJcvMiWUQnAa0rrIkJelgs6YmsD85Twim_xLkkGcd4puiXADX5h3PRzPdhZnWh6wF5PMJNkCq_
 3
X-Sonic-MF: <fabstz-it@yahoo.fr>
X-Sonic-ID: 0161231a-1834-4ac6-b207-2ecebea6d790
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ir2.yahoo.com with HTTP; Fri, 13 Nov 2026 13:00:24 +0000
Received: by hermes--production-ir2-5dd9bf4598-cdfcp (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID b0cfbf3edf66c7acae4f528f93058857; 
 Fri, 13 Nov 2026 13:00:20 +0000 (UTC)
From: Fab Stz <fabstz-it@yahoo.fr>
To: Beomseok Kim <dilddream31@gmail.com>,
 Marek Czernohous <mczernohous@gmail.com>
Cc: nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau: Clear fence channel in no-signaling path
Date: Fri, 13 Nov 2026 14:00:18 +0100
Message-ID: <2430996.ElGaqSPkdT@debian>
In-Reply-To: <179451962164.1494544.10983579250194846394@gmail.com>
References: <20260928081450.19340-1-dilddream31@gmail.com>
 <179451962164.1494544.10983579250194846394@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: WebService/1.1.26943
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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

Hello,

> The patch applies to 6.12.y with an offset; compile-tested there with
> W=1 only. I have asked the reporter (Cc'd) to test it.

Thank you Marek, Beomseok and other contributors.

For my quick test of the patch by Beomseok Kim, please see https://gitlab.freedesktop.org/drm/nouveau/-/work_items/443#note_3781457

Regards
Fab



