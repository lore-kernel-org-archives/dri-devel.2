Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAAECD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6598410E1C7;
	Tue,  9 Jun 2026 09:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="tthgkdlH";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24ACB10E1C7
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780996257; x=1781601057; i=deller@gmx.de;
 bh=Cr+pcPZw8sixdp2F3GU5qI4kZzjgepnc963AEEPSjPA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tthgkdlHRouqqBFzg+KbCLF2/FlKh05KzpUGxj9tQ9AxRKPpJGDlN6Aw/UE6lPOO
 pF1Rx8rolGH431GCL0XSdMxlrpuTo3O7E5+axpk+CVXAhbCpdn/yI+L/KmBbbaOo+
 K+UNicISSdjJqPMSREehCJmjGkR1sAu9mKQK/Rqxfbb0CAQ/72g9+dBU5GfzsP/b+
 yoVziiH6fZtvzFWxh47bYvllUbRe6bBY8wCeEr+5KIY2Atiqj7H0ex7QAzu6DVrnn
 Ly2jjffh30fzRBp0Y05D/PxYM21wKXpRvG6IT4COh5B9yufFL9qICEkwr7YdtsY0p
 Km5/dqtsDIvnrIJXOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1xCmko11OR-00wLKw; Tue, 09
 Jun 2026 11:10:57 +0200
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH] fbdev/arm: Export acorndata_8x8 font symbol for bootloader
Date: Tue,  9 Jun 2026 11:10:56 +0200
Message-ID: <20260609091056.265794-1-deller@gmx.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uh18XWyYxNjvxh6iZLp2CKbaHWD4/rbzo6v9O/BGYxtyv5BOHxA
 XCJn6eCTR1Izbc4Ojdk5cn6QVeb7M46DSKJ3Wn+Dnv+rhh07p6s2UwQrGnaX+JH1+2a0J10
 mdHMgz9VYofmYeXz9VoSWnoxJvtI/LC756Byv7oaSXUxuita5Z7Xr65TWJuzzJHk8j7YDgT
 u+hLlXDjwOAppNMjWhVeg==
UI-OutboundReport: notjunk:1;M01:P0:p50epQe0rws=;nlxu+AuZnCAlxEKoGTIfDHOQXsb
 dJRYx80LLTvCkezuG/oBDqduw8F+XjoCPNrerxXnkQsbEkaaYRvDycxJIJPPcIZ0ErwXjr/a1
 V7JSRUb+keLUC3vRw8vFguMUjUWEt1mLwl5SKDVax8+WVEApGapaNHm+kSeGh+2bTIc03bwEJ
 O619pH5bWGmECekLB5JwjvSg9+CAyTj0bxiUdxLBBOGzl0oXvG/CLnUrIWWHKCC2F0Bq4xZ1J
 d3ZgYzvkQGe0tLVe+r/zFVBrtiEti6HdhjtPMjVA67ElXCPiPpFu7vIQYrs9ByPuKx2ztk+KH
 z/cFa5txE7kelm20Qs+VEtwJ2DjDuPM0BOos+EC3URPOxd3WIGgBlQyFF69GeH/XxTJeQ8SyT
 ZH8pwrPDZ3XbIkQKXH0LVG1P9Iv+M7mCkLgmFIgyvU67c4INaggflVGNLm2l7W4f4TtSzF+6o
 01tsyILkx2bs2bwQY6LPH/pD4QYCfmRLbRcGlejfrmNW2uuonXfnBYXUve19pugACgOeVvlEz
 jCmP83zj1BAv3g9wX18vEY7DTZjDTe/wMp276TnwAdnTuCBUP8RIl59ZT/mvutTWAkedcmSg+
 3jd0Col8296xvlttTN7w2Y1y/syV1+vwi4z8pkdEDiaZACgriMQ9w2o+M6UA2OjKK/7kI9uo0
 mq/YWaUTYnIotWHqxqdJx7LbPVu/qFzDrlQfZRyElnspvVBfMRgtFfCvC0MQ+AR04rjbwQvuK
 z0j+QbsULTmiAQM8SCYtaeA05LR+ZVGavWeEb5fR6Ra3WtWelZxTQOIetkkjcS7n5Yg/oNk8R
 iBnlZFCa0JEBQhrx01zBGdxnzUhj6egGna2gb/0tBqkDzJhQnFRg5vdB+ZpvsW8w3sR5GfDlc
 I3L/O1wypPX12mAtnw8l6Va2m4zLlM9duxpQeOHLoqBmozKNgIrm7xaiyI5ROF6g+1Zr03eOr
 F2g8NltEiIkKyvZtvMxSahxGWa6hwwQoJdDeuDsjYTm43s7v+5IztXcAoD86hX0tQ6Zec6FzL
 qXV40Qt0HLxhGh+Dr13lBsx4OlwFlikwuXRA1W7mDgRMIbabtG86jPVgO3iFtnsCyAV3UeARF
 R/D2uCxCaSgh+iY5SaAMnNbIwmexBsf9oVIYFNXWRNWgKg9H51IsCeoT4Au86dWlqjP19WfXV
 CjADCiiGlzQEJ71LO/38Gb+JCC3w1iYeHreW96JSRni7XRnZkicCO2fTqF/f8dBfQbR32D0Tw
 lg8V1pfGI16mwTuUR4c4g7fUWdDbNOSaLO50bRRBugAAyH2iYi7DC5AbOZOWUNfuF+R0Cg+tM
 8kAv2cR8+PYEASJn0AgnAuo+sem5lGhAUliGaWPsyrCMUCQk0OzynbpAVl8kwJWk9spuizwrD
 KLyMx7VJ6TU9NY+LfmFkgm+10DpGrgkr3LY5qnriYt0puB8mOq0PO8hP54zeI0exZ8GbD5+w1
 dzdGXI2i4CSCAJsVmCe/HjgKcG9aal7ztCi+k7xodvGbsqD2giPpXJShSqZjy2/oBf26W+I45
 Z6AazrF6bCJ2Cln1Uy7+FwYG01H5aaoUHQxB6MUrx1I2oNcVHVPlFwyiMM80vrSq5bxpXt1A1
 FyTUyHqwE1GI3CLXGMBac+jO3HkJb0UVykLTAdQcpf2SnsraqPqLSklrFb3cvukGHIJa4/k5M
 V2aucvIcYnMDFE/TEJEhlRPTF809IEEiy4ukaNkJL8CeHp7BVaWzTaEWYjsmgwN7xuQzX+kDy
 F2EDVBxSPfu6EeNaBiw9WF9TDVBMIbvVodNRvBQSrp3UsVgAhkxoLgsFD7fbANxJrQYV0Av8c
 5BPlivSQW+2CQ3YGWnuVUVsMwlJPLwbU/Q37paP3Dc0LRZHKi45wyFjpcjKuBGD6tCAixi3wA
 U3CtzrOkEH/zTCoWaNVMnCL+FCis0tqTeESZzEnZjpa0IO11vxeT4S8qcVyF60M7BQZGSdyKh
 LLK2c/oCKfMIuLAmCRKrJIYVCOfn3sqruPZNPfX1sGCBmtwo3SatpfgcK26X+Y8fCL7wYUqa/
 6pqao5Rdr52b0qF70U4yvjjFvt3U+6b1FnOv5swemLGNQFG5jlTT9tTyZh0liNzwpGBGo+AUC
 USDCd/zQK5PfCTBO8cokF3LE/qqBE3YpzbkroDSKyuLSI6KpUFIpGkkPxZ90QitQt6kKLTN0J
 3/T3OyADaPRcOtjQVZecE7Etnzlxc88019aEqSiq9Sp+lFQrnW3QJmkKDgwlaCCcsBLkfcC9V
 BlcD/PcadcY3498Z94ui+ckMvYLvlZWHSPFfKlML9Kcp/OACJvXfH4YPRT6PhCMN5uceGV/oE
 wcyJfgQDyX3LLAym9P9iD/C05LGXQwY+xkw6ZsCs/QeH0uEihdsW227vL7WjkFgw1eMBcoE1H
 dtaJReiXZzyJcsw9MDErYyj3YZtHsRPDPWLLFxh7UHXRiyNihgPOAE5VUwVfNwVM5FFshZHzJ
 Gl8wVXAiPF8OgzQZKcI0C/hYiHGDGqg1I3LJD7Yv5Qu7eufN5he93WW9PlcASVHpdanyWaEMi
 XiQtA9eYbGmQM639/ee9hpZ6BrcsFEzf8Qf+B44j+Sbpkz/vm20FV+rvn/A15qU1u6cbw+C9A
 MTog0ZLdAWVtZ1QLmEvV9U9bx4iRvqmy+270b2OlTOoTvcKxffuTnyoLQdiEn1wswop9Fcmqg
 79fB/oFg5EEgx2z1TSdMBRV+8OpGv/AtDQgX8xpis071XWniQwNHp9PwxsE9AuWScUp5kyRhT
 ALQra5iy4Vew9C8QmUO4slY1JyNmumqPEbhg8MB8UZoKgc59m2XGUZ142vIL+sTijfGNTuliP
 S8NnPA04WYGVFMzLuZTAJgMko4I2i8L4foOPQnCCWvY+WmLZAeFpoZP03WFHAs1wb6XdIuorx
 eUIk+a8JdbqzNZHEeesDE3pwV93n8klVRLxnAJmrXZ9aNywoZ0yq321ug4QmzO7D1s55Vs3tU
 rKqn6fmugt4+JhDEy+yrlT/Ds7o25lkKPpwEL4clQYIjD/zViDrDIiNB0o/BNoUhUmq+wATCD
 pv1f7DeWF4isjKkJd4aXH0hAXMg8xC+EFyQkjOKHBZrof7A5Z7qxniu7orz7jpLFaZHa+oEe+
 /eZfoDHgpIIuGcjGulffTdsDM3JlX3ZpEWCbmlxgTHE/GXdncbNeqSDkAi35/wYr6J5VVjzMw
 RFsEs3ZMU6jjSIJdcX2hGIbF0Z9hCjeGHcn7CX2aDg6kDy3fA0TcLzVdQuDt7Gru6Zh1mdUAy
 uyx04JWAYlO7MYnRqn4f2cw8HQCgZKVcOsFy1IfyV9WUrLE6bewdteV94RscVBb1c+743NiOi
 JR4V9g/98OvOSpVOuvmq5LmvgkhgIKW4kQJ5b0YeXe0+ISt/VmCqlVbFFsb1OY+ymtB4g1JPn
 LHSjEWZeGeU0SvSD9mkCnijy4SH7eQQzXxs3+uL2MY71/CbyiaSwWckgiLh2QGNivY4TgVmL9
 b133jxCn1wYKAn2SU2KD6IHzi08rxghHnPht4XbaQ6Z1x2tEJsIY9+YxdZUWllzc5V2CGivNq
 d9YLyEt6n/9ZUIOxdstiw2K5JxD7m5zN4h31Lml7gNFMz4Jl7JkrixTTuDIEPgwt4B6pthZAq
 jpyjb0d87AcKCF5SjK+XqVr4vWhNSoKXeoM6IryksIFU8c8Qonoiyi7+1Pu5AdW8MneVA5DJw
 QVWAyTLN6rtgnPefhKEArjGIgRvSLTkpditLO2ZTV8oh9PwngkIh7jVAa3Mk51BF/E3cmHHZ7
 v7t/wRtO2iZIMiK4Fy1PjbYaEzOqoJByOPdNEzpRPa275QCMmmHzq55U6JByVT2di/YsghTSX
 6AqcB6XmNIhLZbfI+JG/vHpHpjHU4esYlFH+rfrKfFZ0j+eCIl30mCQLrNgJE2nB/bUHuRJBF
 MvbIB5HKUMbwiRTdrkAa1fBqNFR4V4IsUXvi0cyqz9rea/c2LVmej87DXKB6j+6QSEyn54e2L
 ej7sa5DGO6az6kqFM0RJh1DbtHM3bsXI4denqkfTucSK2v4H6HVkg8so0a2D2Uz6ctnwtzbLK
 jQSBAPNHkdKLvr8TlJDbAbLlCdvfrYCF+RUTMne9tlTInXGwL3NCVG+7z2aV02K2thOtoIeTW
 ka1vQZpeOtS6dX7cdQKxRiS2B59LmBaF25j5V3CKCU8Z/9E4CrkyD4bjYZnmxLs+P2XKTtFcW
 qH8NFj7zoxFz6QrFNZYDfGBlyZCV0biK2Q+jydCrvT+KW5bdXu83bRgj9eZkol4BypdBP1lqU
 lzg9LgFyxVQjDp/RHCkPwIyKbTCyOGxrFpVknpbzo/J1t/1wgg6mW25mE7HNHDY6JqIpfirWz
 1Y0dJDIBZTHiOlITy53cZnqOUPgkHQdWfisYVFTL4kxS75YbrtF0cAAPTAat985Iqv0JxsGhi
 98mysDV3KY0l9YYM4AlwebLExH29Vr+MyMtodsQVnT1v0gTcEuoV2G7TpSLbOUQkIaXbn40FC
 hqwjGsD9/l4/ea6El7+r+aEuQ3cPQV7KdstWt11RsWnVbeeScLT4v/W1dLCy2rRO14qi/MyYC
 wIKu5ywIc7bzyF/gb0gC1Hv5PuY714lJf80DpczuXfYoaxUnmWqh8su2tdA3M4GPG2Ze8BEYI
 WLKh8HcEtgd01UPj+V/8xPKb7lbCSwtToHuSSgYswc3smVPnPpOqt4oFJJcPVh2k+/tr8hTSd
 vtxi4lXJOLTAc34om3R5tdw6IeMk5pJk17k0ytKO+fuhyheHTnrtGpeFJVD3qKUCCnBMH+xFx
 YYDjtu2wU5HoG5RanDpx1NC/zo2uRmyUHF1KOPeWAhBLdYo1jm9FuF16DIpbJCYuLHthAc6y5
 4WrX1Y0uDBLtcuEB3k5B6RoBd9OfIO2WMven3wdNzhzHLaQNYszQK8fTVH8ZMAPpy3oDy9AF2
 Hq22iHwgXfXkln0yCejOewBXg0iafFyutEBjRAb1m9BuQ//IiIKYs5BEJsB44NRS7ZLP1b8sR
 jiu1eWY/hVKnNYdxzF2wQ7K5KKr16DFbVnBg6B5VF69Mxx1li9/y1y3d+o8Md3YuvsvoKX0gt
 VH8wPtqeD525gF5fdMNYjAL0DhdCfski/j2kolwFraTP26Xdu11y/KotV2Y1EJ7/KPsB63Aim
 02hMGBayPRdCp54DLxtLrQVzDSnjpSn0hngLQZFBYkLvaRDxACU2H7TgZrre42fsGE2TCsePN
 ck2ciuJLQnHWibrVpZNw+RnEOaeod74YxufqqWtzlimXiAbvGRUo+WchoRCrVVYokyikiaZfZ
 HxEMEcvecYQxHEs3D/Wk3CiJD/VOoV8t4qkDMexNqhz4E2RuwOs1lMSjVTyzwhYnuXyVllkXj
 tlC4xdDDMDcpJTbiOT6RlxOpbNjm6yjQ2PaTjHXSSZ2zGaqFWT7D6Ya72+rrR4ith+N/wDoeH
 jrjK4bQeeL2PEElS8E3w97g1EIJPlwOGl01mlZSy0sMRghoVQBbdaKJ4ZiPY8uugoHaeXrtdh
 Lx4fBqRBqvpJ601kxCrgmQMci2QoGC1HESxYDdvbjMGdoQ/lTB850WC7V1agjPG8vnclRi+Z1
 R0H5cEBkzgrrH9rz2pRJZ5WCoZIIWIih+K4/tVYUVMlhC8bb8zd/XclOurF+cBsthklmgNjWF
 0ZRtgRV2h8TGzzlxdg=
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

The text display code used in the Risc PC kernel image decompression
code uses arch/arm/boot/compressed/font.c, which includes
lib/fonts/font_acorn_8x8.c, which further includes <linux/font.h>.

Since commit 97df8960240a ("lib/fonts: Provide helpers for calculating
glyph pitch and size") <linux/font.h> contains inline functions that
require __do_div64, which is not linked into the ARM kernel
decompressor. This makes Risc PC zImages fail to build.

Resolve this issue by defining the BOOTLOADER symbol and use it to avoid
a static declaration of the acorndata_8x8 symbol. That way it can be
referenced by the arm bootloader, and other static math functions and
symbols (like __do_div64) stay static and don't get unneccesary included
in the ARM kernel bootloader decompressor object file.

Fixes: 97df8960240a ("lib/fonts: Provide helpers for calculating glyph pit=
ch and size")
Reported-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 arch/arm/boot/compressed/Makefile | 2 +-
 lib/fonts/font_acorn_8x8.c        | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/=
Makefile
index a159120d1e42..e3f550d62857 100644
=2D-- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -157,4 +157,4 @@ $(obj)/piggy_data: $(obj)/../Image FORCE
=20
 $(obj)/piggy.o: $(obj)/piggy_data
=20
-CFLAGS_font.o :=3D -Dstatic=3D
+CFLAGS_font.o :=3D -DBOOTLOADER
diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
index 36c51016769d..4ff52c79f8c4 100644
=2D-- a/lib/fonts/font_acorn_8x8.c
+++ b/lib/fonts/font_acorn_8x8.c
@@ -5,7 +5,12 @@
=20
 #define FONTDATAMAX 2048
=20
+#ifdef BOOTLOADER
+/* The acorndata_8x8 symbol is needed by the ARM bootloader too. */
+const struct font_data acorndata_8x8 =3D {
+#else
 static const struct font_data acorndata_8x8 =3D {
+#endif
 { 0, 0, FONTDATAMAX, 0 }, {
 /* 00 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* ^@ */
 /* 01 */  0x7e, 0x81, 0xa5, 0x81, 0xbd, 0x99, 0x81, 0x7e, /* ^A */
=2D-=20
2.54.0

