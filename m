Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DEAC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C46910EF6E;
	Thu, 27 Aug 2026 09:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.pl header.i=@yahoo.pl header.b="niMehCK+";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com
 [34.2.82.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0817410EDB0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048;
 t=1787770871; bh=981Y45l28tEVjfFWKMb+Asr6a0VG+kmV1zHPYaqRojQ=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=niMehCK+HhPrpobEaqiZVCIO9pVI+cFv7EmvinS9yBUC67nFhyUosVENBcrc3nE0+e/mMK2MHUJRBxa79FnHd20b/AI04PTJiNTsBKgXcx8HQiHtFkGDamegDqo4btIHHCpMbt/WKRzLZ9NbVoep5OxnVR7QbpAnKpBSK6ISgjYDJweMzvL1Qtx1FfXSRSIbPRyVTGT5XAAtPft22II1cCdtxZxFe+jfobunfQYdkOVEfUW/jKjdVimkwM06zk1P1DdWBk0KTvahQHVUIMWN4gSJPi9+lNZmyoJw26AcbgyoqEVA/t0c+HuI4/1NwBFzRJZtJ58gHP+tE1OWwOvdcQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787770871; bh=C6Bxtza3utP4+rvJ6iFwGXaCY4zvljhrrp9omReIVmh=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=p8pOFef9qj8CmWwS5TryztJ9VOZ6sW6xkXGmQuKRKWN/s1jEDSote2hyuokIXTkxK3zaLWs0K3ceGCCrG3ASf4+Bgd3biPp9qCxUzvksGvIy+PBMlBqUIMPSE9wqzrQjP78S1oY7OZe2iSquUjW2+8SnUBvN3x3J/8jtUULBe6COm7kjXs7NhnhAtl9g9vqH6ktn6P2DNinaED6AphuTKMs0WJTNb+1fuwFG0xUTJBAjmJJVTIIPevdd+pb8QfGS6wIQZfMITrT2ioaBjyaufVev8LeH05qsTLOf90KzNipCy3jmMGaj1vT8ROqJ3whDTlf9fYP5u9lD6BA800q3mw==
X-YMail-OSG: Qxfy9cYVM1mO1VoDKdkSu9WDCqfNBBcarC6p5oTbNOeupdcjQZT27PAJCuCyO.1
 YBcF1lzkXsZyKlJNlwzaiiWxemdzp.l90hcoFHKE8qB.s6XyDMNot7sS_lXDxEBhpIWY0NPfk3lq
 VZtWcFuS7bnMRXNeLd5eTEH0biPVXfz9QWUggPRyvk_GjEbLxIyAjE9SQ46NzcmJ7p5vfOiHgXM7
 lfrcGqfXC_G0PnRQbK85y9Oy5ogh0wQgN08PKw6K3cxPxpodtn0o0L2H5SS14avvrViqogziM_pu
 be34TE1_QDrhZm6XAbI6wKiXLpUp1PXA1vYIb7nkClKeOsZ.Kayy.2P4rG8JxC3XLXBrlV6Ae0bM
 KU30r73Hh5oQDDrqIYh.Iz4MZgdWLgqIlUPWHVZPMNG7gOURopBAFqmGQ5S.h5VLdrXEAzwipYET
 ljQA9iuXIhwYvxfEsltyKgc3SbVoDvWUbw1FqCHDxNEx8tmExhYK7ydkS2qfMzl.aYJ.Z1VYciI0
 l_OHIpfUlrG5tZDPMEWwOPA2eEo0n4jE_mT1Q24Xcamsjr_v7CsfPGoFdjnGMcv_R_zQHGkzqkl0
 3bOnTQZ.J9wsgFmZyUsEaEyGVXAg.tirsP2IXKD_ae1PoFvwJ5s1tgIxjsKDqnzwBFFypyZ.7Sp6
 iCwykGenmAlwNpIOIEjOSnvFxU5KuNYC53cV8CFHMJ5q4RpufYqVdBf_Eg.s7y1c_jzVUIFspz.t
 .AjqlHsusPRf7FSdMma8GMcePf7zN_iB23DB8owfQZ1eBRwEOtUUdyVRj5OM7k2RjDkZQDHwYgUe
 sdzVL_I_5FNTNnT_1SFgQydYB3w2Dmz4Dtea8n25hOFUcgqi8k4UE1fhyeIIErGtoV73cp2NSpDv
 ZtLdvy.lTGAP9aE65dpu9XUTr6iieVssAWbsE6Wx0maKWigJeMiFX2_OxZ.vICGRBz3mgMa6kyYU
 mlhSv_f3kNEi3CpwemEoD1YksiumhLBGt4pYH8HmWa7faRJb2RA3iD2HXro3Q0RGhcO2Svnp0G8A
 Bu2K15kiB7IukOwHcWYe5qUIfkrvwvKUrNkb6MOimsK.atyM5jPm9Ac.b31tXChF9ehr6RcmYEfW
 8VgPnJNnHSsOu67M5xd0hxAIzmK49kmhUzQsYOLu2row3Z49JksMo1EQ2.KFfITOkWJdRqKnnmFa
 YJyUtbxQYB.907EPC.vqYRisQ1YwvEkCdBgJwLhZv20nwJ8ZxXk6LomzPvdpJj4KVabgIgk9MGxo
 TV_odT9gfS9YZCzSJf9zkQVdGyFOXPoe3aMwEbnQFKIs67.XBm6dVDM4LSAzxppJMRpe1hwGyZ6Q
 n0ixJDevHwH2OuKr26AvrvNT1x_4deOaDzyD.fR1KD_ODqIBdB8Q8jMznBF61lMoCOCd_IwbxpQ5
 qps.eylMes7FiKyljnEaBkqLHmY3WyfAzzWlOBAd1I7ACBmnHfSL4poE7Bx4FmM.sQjy0QONR4yo
 AUJ3hvYL6QI2ULzQS8_0yhFH6a7hOE572s7yf8j8Mp0pT89sNdTJ1A14O7utVFK5oM9WLksydTm6
 GmD8YtcLSthaIq60AExOJhY8.RTpdbiT.8sm70BWtNrsPblvsUL.t_0C1IBjqdiQUyDHzJqTu1Ul
 iQNAvXfU7nvmvzC7pQ9OHoom28nvLGwwd9dQI8ZWCxAN2.bqujyK3Ui3WoYr.um3EYZtf7aCEw8P
 VNutfwndbtLOREqEsfwHoT1Rjbpz5rx2_MOQfelmeKNbtLBRHZG8uszm0oXm.vNi7Lo6BMun.7KV
 wqwSfX8bBvXo6b9dnULPIS3Mq3hNNzvHbWmYoS5mrtRPQiaExjQmEqSmngkHABpDs6r2CY9ioKuH
 9fE6rPi.CnrJvkp2IjOI6lpSgJVEQ5fB4gJzUjuJH98MiNGK8pio8KA6GWLh9apdJimU9qdOC8eY
 97hb6xj7bLwIMmwK7s2zXQJsISKESQlliuOWZ54QhrQXH.ahY7SuSsR5WoTUqiX8BepXXVv3zUp6
 uTCyycD_gFsF8vr29t0wA2F67RF.UpjOt7bb9tyR.0UM8mRNSlZ1hSO9najUELl.S5nzfG0VIhHi
 NHl8NggPUuddsgorT6rwS
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 39fa4574-2f94-4ffc-af95-d525be5494ba
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-101 with HTTP;
 Wed, 26 Aug 2026 19:01:11 +0000
Date: Wed, 26 Aug 2026 19:01:07 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, 
 "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Dan Carpenter <error27@gmail.com>
Message-ID: <288624768.4518972.1787770867491@mail.yahoo.com>
In-Reply-To: <aowH8YrNTzAJYRa9@ashevche-desk.local>
References: <20260820-fbtft-v2-final-v2-1-44d107b04634.ref@yahoo.pl>
 <20260820-fbtft-v2-final-v2-1-44d107b04634@yahoo.pl>
 <aowH8YrNTzAJYRa9@ashevche-desk.local>
Subject: Re: [PATCH v2] staging: fbtft: prefer snprintf over sprintf in
 fbtft-core.c
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_4518971_2063055525.1787770867490"
X-Mailer: WebService/1.1.26380 YMailCLDNorrin
X-Mailman-Approved-At: Thu, 27 Aug 2026 09:44:45 +0000
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

------=_Part_4518971_2063055525.1787770867490
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=20
Correct - no compiler or static analysis tool flags this. The overflow is m=
athematically impossible for these argument types, so the patch doesn't fix=
 an actual bug.

I addressed Dan's specific wording feedback but missed responding to your c=
ore objection about the patch being unnecessary. Given the above, I'll drop=
 this patch unless you see value in keeping it as a documented safety margi=
n.

Regards,
Tomasz Unger
    W poniedzia=C5=82ek, 24 sierpnia 2026 10:59:40 CEST, Andy Shevchenko <a=
ndriy.shevchenko@intel.com> napisa=C5=82(-a): =20
=20
 On Thu, Aug 20, 2026 at 06:58:12PM +0200, Tomasz Unger wrote:
> Using sprintf has potential for buffer overflows if the formatted

sprintf()

> string exceeds the destination buffer size. Replace it with
> snprintf, passing sizeof() of the fixed-size stack buffers

snprintf()

> (text1[50] and text2[50]) so the write is always bounded.
>=20
> An overflow is impossible here: even the worst case for the
> argument types (size_t for text1, three ints for text2) still
> fits within 50 bytes. Use snprintf() rather than scnprintf()
> since the return value is not used here.

Then why the patch is needed at all? Do you have any compiler that warns
you about something?

...

It looks like you ignored all my comments against v1...

--=20
With Best Regards,
Andy Shevchenko


 =20
------=_Part_4518971_2063055525.1787770867490
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"ydpcc7cbaeayahoo-style-wrap" style=
=3D"font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:13px=
;"><div></div>
        <div><br></div><div dir=3D"ltr" data-setdir=3D"false"><div>Correct =
- no compiler or static analysis tool flags this. The overflow is mathemati=
cally impossible for these argument types, so the patch doesn't fix an actu=
al bug.<br><br>I addressed Dan's specific wording feedback but missed respo=
nding to your core objection about the patch being unnecessary. Given the a=
bove, I'll drop this patch unless you see value in keeping it as a document=
ed safety margin.<br><br>Regards,<br>Tomasz Unger</div><br></div>
       =20
        </div><div id=3D"yahoo_quoted_7781964324" class=3D"yahoo_quoted">
            <div style=3D"font-family:'Helvetica Neue', Helvetica, Arial, s=
ans-serif;font-size:13px;color:#26282a;">
               =20
                <div>
                        W poniedzia=C5=82ek, 24 sierpnia 2026 10:59:40 CEST=
, Andy Shevchenko &lt;andriy.shevchenko@intel.com&gt; napisa=C5=82(-a):
                    </div>
                    <div><br></div>
                    <div><br></div>
               =20
               =20
                <div>On Thu, Aug 20, 2026 at 06:58:12PM +0200, Tomasz Unger=
 wrote:<br>&gt; Using sprintf has potential for buffer overflows if the for=
matted<br><br>sprintf()<br><br>&gt; string exceeds the destination buffer s=
ize. Replace it with<br>&gt; snprintf, passing sizeof() of the fixed-size s=
tack buffers<br><br>snprintf()<br><br>&gt; (text1[50] and text2[50]) so the=
 write is always bounded.<br>&gt; <br>&gt; An overflow is impossible here: =
even the worst case for the<br>&gt; argument types (size_t for text1, three=
 ints for text2) still<br>&gt; fits within 50 bytes. Use snprintf() rather =
than scnprintf()<br>&gt; since the return value is not used here.<br><br>Th=
en why the patch is needed at all? Do you have any compiler that warns<br>y=
ou about something?<br><br>...<br><br>It looks like you ignored all my comm=
ents against v1...<br><br>-- <br>With Best Regards,<br>Andy Shevchenko<br><=
br><br></div>
            </div>
        </div></body></html>
------=_Part_4518971_2063055525.1787770867490--
