Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF67606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nlv3bKKO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB34D10F326;
	Tue, 20 Oct 2026 07:37:06 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CC610E2EB
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 20:42:15 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8a052aff9e9so1616337b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792442534; cv=none;
 d=google.com; s=arc-20260327;
 b=WKtY48nGBGde6S5vKih+5IAEwz8cB0nwFijc8PJefcAP01CWKLili1VT1GJZkSsZxQ
 cfsGdKG4IOUxRY1etQX82L+x8D4HDN2E2c5u2S2VB1fQLufrlj/TGXjeDlj4WDzXOaBh
 setFee1dltFAWOKRwSFi7BVG3P0xgF3AZ/qZCK9e+xGeFugCaWRKi5jxbwdN6MHulQET
 v04e9Fw32FP8jvr4RbqDAYgkvPuFkvRMp5mpIbObnf71SZazXfuuQMsjHm1X8zyM3AHq
 v2I9eREFyLlsmx50XqRpRZ3ayqgAvQ/Hc+pvo1gPpoAgxc9WVOhPe4/oovYZiK3EbW2b
 Fvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=QFif6oWSWGDy/I0Bph6cQI6+LzcHNaOPBd3ubnCjtcg=;
 fh=KoONDO2Wew5fKyaxWBuKtolhlaYqZoXiuqr7A1Q/GLU=;
 b=jY+dcMPGCmGwp92rZ7e7W0jOWGUUiOCMaL5HmPOq9vCtLqvP9Bqlr92MuRRtAcvNQc
 GeYXQSxw0QFY5kEtpXsNQ50+gitf4WpbeZDZzDE+E5MeOzD3qY7kmuiNSjl+BSZcIsgt
 8Ur5Do67D0JVwqmnMf2zsyJ/qTG0tz57tu1+1x+2vqbreP6lJ0GZqo6td1vNih5GPY2E
 KZZr18H2OThnmA11VAcE94u+8/32vzSsLa9Jcyrv8agJLEoUD4kxRyMXLHSxYD0A5JbE
 9W88EIn/X8lIKw4AhkdQQL8T7OkdN9uTHJSuZYe/9UrRQgrcda6irnpD7yQeu6VBKd1t
 ++WA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792442534; x=1793047334; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QFif6oWSWGDy/I0Bph6cQI6+LzcHNaOPBd3ubnCjtcg=;
 b=nlv3bKKOjRZ5+cZTII+q+oqcD/1FT9xNtxUx3kzV5NF2JjqznnW/E1QGYDHYfwS3t7
 6eoECG+Kt6qlMiKKQ1aNwfiJvE99C9uZ58WaTqJ1lZrXIWzZbl/voa3fgl9HhoQv1yhn
 vR8iUIk3C8X8Wj15u1pEZlKajr09unni8FuSlTHLx5ooyi2p+F87Tx3Dr6Do083vezKD
 lSED6aHhCzl2vbVpV0Igt/0cjv53Rg0LkyMfpJ3qtE6rp3F2L0c27nxfomeRxARRH6OI
 npfPwMRPP2quvu37isCJvfAgd3gn8FRliHhOIgDnAl2hMxCYk0fPEz0MR/IPglNomUyP
 /Nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792442534; x=1793047334;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QFif6oWSWGDy/I0Bph6cQI6+LzcHNaOPBd3ubnCjtcg=;
 b=WwNpAlFX5ROCdqWrhHDKrYrdOyAQQb8XBjWzViYA77qHBrqBXr4x6CHUlvui1ICPjV
 Vk8vPQspztBVt5ReSgBPUSgLJlR0U+4mlI0Ipuufa70R54F0w7xMtviHWSJbsIUTWkIQ
 7JKajZVvmuU/BpAhQit4XGpX0K9TVleq1e9b1Pn6ohwy3LoxgiIEetztkq1z/b3g1J30
 F76JAWJs7cDvW1mM6XW9qAxsNUZ1qnJqspgP2yvNJlA9qQ6X5Y/KXSLz3B0DhMp92gCs
 g2vu917qtt1pw+ARQewVttsDNvQAGB1pbpYZ/PfjMGybCjUr2iKa8L1nnOeDsU8gf52l
 ub5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzh2uXR2CChLfmK3q/Fq21OILW/v0PvS0Y35H0HN4kAwweu9PLt68IuMRLHvrs9Ec8QJBr31Bjongw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLm+XPb5hyrOXbMIv5/HRLG9iCJ1ablxFDssL3GTLgbKq147owR
 3Zom77e6axEsdsmkMQQTiTzoqAxfAkEHkPhIQQ/v9ZKu8KNkCqqoJnWJqtUkTLZJJ4fGmVP5Uie
 hjKAHuzUDd+9UFnnANH6hOyxHGJBAMmI=
X-Gm-Gg: AYBFou3ctqKcxOyLtSzccenG0S+o8aBZDtyJ2EJOiTRIM1vC76aDRmlllONMw12SaQi
 Ci86MpthTf4oFlTATySo/PKcAlTUuRFZ6zFuOIqld17Xv3357rlQF2mO4UoUt5EX7MEYhzpqnK8
 7wVMG3dpg3ylFkq+mrK6Z2Ndn8dkZF5eAM15PFI37TAJ1eNb44j5tJzIhswLVrRC+vY4uWLoAzF
 vxu+QrYpC4Wt374+ZFYkEgnOYuMnRpRd7h8KbOo4KJeET9ninCwiTmRKVV/9zSnvBsJJYtbYezD
 HzPl0GhFOdcIZuSBv65lDHBBSyWZvlyX6uFOZKP2E3loAon+FbXycEowguddZ7/AoVkyUK2O0pr
 QUvMxE6uHSiGtUcem1BZp/vvbHP+5G3p9SL2fM+mRGl0yjaw7+YdxYEqt/Uf7W69CQa6HO07UJu
 JSlUhwUQGx7KNzJYt6u0Us+Rn/XekIV6jff1uoFBx/0Jk8fb47EjY=
X-Received: by 2002:a05:6a00:aa89:b0:890:a777:1026 with SMTP id
 d2e1a72fcca58-8a0490d2d70mr6544862b3a.0.1792442534495; Mon, 19 Oct 2026
 13:42:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Kenneth Assogba <kennethassogba@gmail.com>
Date: Mon, 19 Oct 2026 22:42:01 +0200
X-Gm-Features: AclHuK8sOrZ53-lEWSI1zofxxzXTSchwDz295PqOIj4ZjZYxg4eLxT_sozQ5nE0
Message-ID: <CANuUoF7c0tNjogjAZVBMd_reP1Z3wGOj3ybT0EB69ecWcNbKjQ@mail.gmail.com>
Subject: [RFC PATCH] drm/i915/display: limit power defaults on affected
 Latitude 7490
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="0000000000008ca08b065e378c19"
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000008ca08b065e378c19
Content-Type: text/plain; charset="UTF-8"

A Dell Latitude 7490 (BIOS 1.41.0, PCI 8086:5917, subsystem 1028:081c)
repeatedly froze with its internal display active on Ubuntu
7.0.0-38-generic. Logs contain skl_dpll0_update and
gen9_disable_dc_states warnings. The user reports several freeze-free
days with PSR/DC disabled, including undocked sessions; swap/zswap
changes are a confounding factor.

This RFC disables automatic PSR/DC defaults only for the matching
PCI/DMI identifiers and preserves explicit overrides. Linux 7.3 with
this change built and booted. Without i915 overrides, global
parameters stayed -1 and device values became 0; the internal display
was enabled. Initial checks found no earlier warning names, GPU
hang/reset or OOM patterns.

Unpatched mainline reproduction, separate PSR/DC tests, bisection and
power measurements are missing. Power consumption may increase. Is the
early per-device parameter hook appropriate, and should panel
identification further narrow the match?

The attached text/plain RFC preserves the patch bytes; Gmail changes
pasted diffs. It includes my DCO sign-off and Assisted-by: LLM
attribution.

Report and tests:
https://gist.github.com/kennethassogba/b8332d07d6e4c508307b625cc8a037b6

Kenneth Assogba

--0000000000008ca08b065e378c19
Content-Type: text/plain; charset="UTF-8"; name="latitude-7490-rfc.patch.txt"
Content-Disposition: attachment; filename="latitude-7490-rfc.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mvfpysgp0>
X-Attachment-Id: f_mvfpysgp0

RnJvbSBhMmY2Yzg3YjM3MDUyODNhM2UyYzY2YjJiODVhMDRlODk1NDg4ODc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBLZW5uZXRoIEFzc29nYmEgPGtlbm5ldGhhc3NvZ2JhQGdtYWls
LmNvbT4KRGF0ZTogTW9uLCAxOSBPY3QgMjAyNiAyMjoyNjozNCArMDIwMApTdWJqZWN0OiBbUkZD
IFBBVENIXSBkcm0vaTkxNS9kaXNwbGF5OiBsaW1pdCBwb3dlciBkZWZhdWx0cyBvbiBhZmZlY3Rl
ZAogTGF0aXR1ZGUgNzQ5MAoKQSBMYXRpdHVkZSA3NDkwIHdpdGggQklPUyAxLjQxLjAgcmVwZWF0
ZWRseSBmcm96ZSB3aXRoIGl0cyBpbnRlcm5hbApkaXNwbGF5IGFjdGl2ZSBvbiBVYnVudHUgNy4w
LjAtMzgtZ2VuZXJpYy4gVGhlIHJldGFpbmVkIGpvdXJuYWwgY29udGFpbnMKc2tsX2RwbGwwX3Vw
ZGF0ZSBhbmQgZ2VuOV9kaXNhYmxlX2RjX3N0YXRlcyB3YXJuaW5ncy4gVGhlIHVzZXIgcmVwb3J0
cwpzZXZlcmFsIGZyZWV6ZS1mcmVlIGRheXMgd2l0aCBQU1IgYW5kIGRpc3BsYXkgQy1zdGF0ZXMg
ZGlzYWJsZWQgdG9nZXRoZXIsCmluY2x1ZGluZyB1bmRvY2tlZCBzZXNzaW9ucy4gU3dhcC96c3dh
cCBjaGFuZ2VzIGFyZSBhIGNvbmZvdW5kaW5nIGZhY3Rvci4KCkRpc2FibGUgYXV0b21hdGljIFBT
Ui9EQyBkZWZhdWx0cyBmb3IgUENJIDgwODY6NTkxNywgc3Vic3lzdGVtIDEwMjg6MDgxYywKYW5k
IGV4YWN0IERlbGwgTGF0aXR1ZGUgNzQ5MCAvIEJJT1MgMS40MS4wIERNSSBtYXRjaGVzLiBQcmVz
ZXJ2ZSBleHBsaWNpdApwYXJhbWV0ZXIgdmFsdWVzLiBBcHBseSB0aGUgZGVmYXVsdHMgYWZ0ZXIg
dGhlIHBlci1kZXZpY2UgcGFyYW1ldGVyIGNvcHksCmJlZm9yZSBkaXNwbGF5IHBvd2VyIGluaXRp
YWxpemF0aW9uIGNvbnN1bWVzIGVuYWJsZV9kYy4KCkxpbnV4IDcuMyB3aXRoIHRoaXMgY2hhbmdl
IGJ1aWx0IGFuZCBib290ZWQgb24gdGhlIHJlcG9ydGluZyBtYWNoaW5lLgpXaXRob3V0IFBTUi9E
QyBib290IGFyZ3VtZW50cywgZ2xvYmFsIHZhbHVlcyBzdGF5ZWQgLTEgYW5kIHBlci1kZXZpY2UK
dmFsdWVzIGJlY2FtZSAwLiBUaGUgaW50ZXJuYWwgZGlzcGxheSB3YXMgZW5hYmxlZCBhbmQgdGhl
IGluaXRpYWwgbG9nCmNoZWNrIGZvdW5kIG5laXRoZXIgZWFybGllciB3YXJuaW5nIG5hbWUsIEdQ
VSBoYW5nL3Jlc2V0IG5vciBPT00gcGF0dGVybnMuCgpUaGlzIFJGQyBwcm9wb3NlcyBhIG1hY2hp
bmUtc3BlY2lmaWMgd29ya2Fyb3VuZC4gVGhlIHVuZGVybHlpbmcgY2F1c2UsCnVucGF0Y2hlZCBt
YWlubGluZSBiZWhhdmlvciBhbmQgdGhlIG5lZWQgZm9yIGJvdGggc2V0dGluZ3MgcmVtYWluIG9w
ZW4uCkRpc2FibGluZyB0aGVzZSBmZWF0dXJlcyBtYXkgaW5jcmVhc2UgcG93ZXIgY29uc3VtcHRp
b24uCgpMaW5rOiBodHRwczovL2dpc3QuZ2l0aHViLmNvbS9rZW5uZXRoYXNzb2diYS9iODMzMmQw
N2Q2ZTRjNTA4MzA3YjYyNWNjOGEwMzdiNgpBc3Npc3RlZC1ieTogTExNClNpZ25lZC1vZmYtYnk6
IEtlbm5ldGggQXNzb2diYSA8a2VubmV0aGFzc29nYmFAZ21haWwuY29tPgotLS0KIC4uLi9kcm0v
aTkxNS9kaXNwbGF5L2ludGVsX2Rpc3BsYXlfZGV2aWNlLmMgICB8IDI3ICsrKysrKysrKysrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5X2RldmljZS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kaXNwbGF5X2RldmljZS5jCmluZGV4IGYxN2Zj
MmMuLjc3MGY1MjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50
ZWxfZGlzcGxheV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2lu
dGVsX2Rpc3BsYXlfZGV2aWNlLmMKQEAgLTMsNiArMyw3IEBACiAgKiBDb3B5cmlnaHQgwqkgMjAy
MyBJbnRlbCBDb3Jwb3JhdGlvbgogICovCiAKKyNpbmNsdWRlIDxsaW51eC9kbWkuaD4KICNpbmNs
dWRlIDxsaW51eC9wY2kuaD4KIAogI2luY2x1ZGUgPGRybS9kcm1fY29sb3JfbWdtdC5oPgpAQCAt
MTY5MCw2ICsxNjkxLDMxIEBAIHN0YXRpYyBjb25zdCBjaGFyICpzdGVwX25hbWUoY29uc3Qgc3Ry
dWN0IGludGVsX2Rpc3BsYXlfcnVudGltZV9pbmZvICpydW50aW1lKQogCXJldHVybiBzdHJsZW4o
cnVudGltZS0+c3RlcF9uYW1lKSA/IHJ1bnRpbWUtPnN0ZXBfbmFtZSA6ICJOL0EiOwogfQogCitz
dGF0aWMgdm9pZCBpbnRlbF9kaXNwbGF5X2RldmljZV9hcHBseV9wYXJhbV9xdWlya3Moc3RydWN0
IGludGVsX2Rpc3BsYXkgKmRpc3BsYXksCisJCQkJCQkgIGNvbnN0IHN0cnVjdCBwY2lfZGV2ICpw
ZGV2KQoreworCXN0cnVjdCBpbnRlbF9kaXNwbGF5X3BhcmFtcyAqcGFyYW1zID0gJmRpc3BsYXkt
PnBhcmFtczsKKworCS8qIExpbWl0IHRoZSB3b3JrYXJvdW5kIHRvIHRoZSBoYXJkd2FyZSBhbmQg
ZmlybXdhcmUgcmVwb3J0ZWQgYWZmZWN0ZWQuICovCisJaWYgKHBkZXYtPnZlbmRvciAhPSBQQ0lf
VkVORE9SX0lEX0lOVEVMIHx8IHBkZXYtPmRldmljZSAhPSAweDU5MTcgfHwKKwkgICAgcGRldi0+
c3Vic3lzdGVtX3ZlbmRvciAhPSAweDEwMjggfHwgcGRldi0+c3Vic3lzdGVtX2RldmljZSAhPSAw
eDA4MWMgfHwKKwkgICAgIWRtaV9tYXRjaChETUlfU1lTX1ZFTkRPUiwgIkRlbGwgSW5jLiIpIHx8
CisJICAgICFkbWlfbWF0Y2goRE1JX1BST0RVQ1RfTkFNRSwgIkxhdGl0dWRlIDc0OTAiKSB8fAor
CSAgICAhZG1pX21hdGNoKERNSV9CSU9TX1ZFUlNJT04sICIxLjQxLjAiKSkKKwkJcmV0dXJuOwor
CisJaWYgKHBhcmFtcy0+ZW5hYmxlX3BzciAhPSAtMSAmJiBwYXJhbXMtPmVuYWJsZV9kYyAhPSAt
MSkKKwkJcmV0dXJuOworCisJLyogUHJlc2VydmUgZXhwbGljaXQgbW9kdWxlIHBhcmFtZXRlciB2
YWx1ZXMgZm9yIGZ1cnRoZXIgZGlhZ25vc2lzLiAqLworCWlmIChwYXJhbXMtPmVuYWJsZV9wc3Ig
PT0gLTEpCisJCXBhcmFtcy0+ZW5hYmxlX3BzciA9IDA7CisJaWYgKHBhcmFtcy0+ZW5hYmxlX2Rj
ID09IC0xKQorCQlwYXJhbXMtPmVuYWJsZV9kYyA9IDA7CisKKwlkcm1faW5mbyhkaXNwbGF5LT5k
cm0sICJBcHBseWluZyBMYXRpdHVkZSA3NDkwIGRpc3BsYXkgcG93ZXIgZGVmYXVsdHNcbiIpOwor
fQorCiBzdHJ1Y3QgaW50ZWxfZGlzcGxheSAqaW50ZWxfZGlzcGxheV9kZXZpY2VfcHJvYmUoc3Ry
dWN0IHBjaV9kZXYgKnBkZXYsCiAJCQkJCQkgY29uc3Qgc3RydWN0IGludGVsX2Rpc3BsYXlfcGFy
ZW50X2ludGVyZmFjZSAqcGFyZW50KQogewpAQCAtMTcxMCw2ICsxNzM2LDcgQEAgc3RydWN0IGlu
dGVsX2Rpc3BsYXkgKmludGVsX2Rpc3BsYXlfZGV2aWNlX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2LAogCWRpc3BsYXktPnBhcmVudCA9IHBhcmVudDsKIAogCWludGVsX2Rpc3BsYXlfcGFyYW1z
X2NvcHkoJmRpc3BsYXktPnBhcmFtcyk7CisJaW50ZWxfZGlzcGxheV9kZXZpY2VfYXBwbHlfcGFy
YW1fcXVpcmtzKGRpc3BsYXksIHBkZXYpOwogCiAJaWYgKGhhc19ub19kaXNwbGF5KHBkZXYpKSB7
CiAJCWRybV9kYmdfa21zKGRpc3BsYXktPmRybSwgIkRldmljZSBkb2Vzbid0IGhhdmUgZGlzcGxh
eVxuIik7Cg==
--0000000000008ca08b065e378c19--
