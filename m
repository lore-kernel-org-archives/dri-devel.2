Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652B606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=L9tzhG1Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE4C610EA1A;
	Sun,  1 Nov 2026 12:01:47 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn19010003.outbound.protection.outlook.com [52.103.66.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D9710E325
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 10:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYWX/DpF6H93TUC7bJ+K0PBzd4bNTodf5N66d1BH8IlcntbxC++wZ857IM1oSC4WOV4J9A2UKky3J/lee8Zs74O8E4SmTpr6oggiWK1yPhz+NHAoGsyd6HKfz4PkxY3pJ7ouCRD7+ZVssyXXtKp5sB7i/KPmEOO8d8hYkJ4xtCdFAGkMyD7RxVHWaslUfuh6MxNcdGr22qn4aPIJ0iyGLNUuMG/03/6elmbiihIJOIZP749GEbKocwf8VX2iMEEHr3yDKQWLgvo3yXYkjVWH6UnOg3A3B4DvTGDFov5P1IOD8bSAyZEnXmgI1xPkFzL+7TjmdCop/UpkUwml7Ikfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+IhlP58nSglicUeSCO44NdiLaSIJUd3Ipf739ZZ9gw=;
 b=GyaFbwnTgt8QD2cH3+N3nwg5KBiGNx263xzcUlAwrPoFiaXm/gKPfNdTnz5aLS21sYPZFacxxSNnt9BicnhMVQU+0PLacFr7fJXXNTsqkL78FAM+3jT4G1by21sUx6kDGcsk8nd44VMzVKoenMhK180AbK887wNxUluhWZ3MRGOcKfPG/LzMYunJHtKTunvRpbPLsERZfgGSIaS1CGNRSnMlkARKSLLx+T9ta2uMoyjO9F2A2gB+qQgLQk3XUzE9WhsO5/ybU074AuUGUUqqhsd/ogg1jkaVoNqY2VObZHv72mlAF+kmNHNSy+oGxqS7Y2z0VcfL2V9TaZt5wYrW8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+IhlP58nSglicUeSCO44NdiLaSIJUd3Ipf739ZZ9gw=;
 b=L9tzhG1Q3DoUjJmZNoIplAOEwi76zn2xh0yy1hZxV+QUdiOZbtnrAaYwaGagR+JnEZo4sPIoUcV+vAcZhuWYXb9ZzNdZqUF36qyDZ6L3xT81oocpg1JISruhfcM3MnbDl6jSlD9TYznkL1xUmM7ndYsq34xuRqydcqU+mLC0ZaDAb3rphwfPI9sRvFcAS3niGtDgztsDjqkvrwFI3FAgzJ35C4LwysLKOtO4DqN6K4PM2E5X1eo8XIXMXNyb4XjYibrIDIS6NN1edxN7W+iOF2TLsALqHzrXGuAfca9nwlQMSldNrnuO4oxXnbijPCrhwBV4efW51fYBvwCbaxNZIg==
Received: from TY7PR01MB804852.jpnprd01.prod.outlook.com
 (2603:1096:403:403::19) by OS3PR01MB8778.jpnprd01.prod.outlook.com
 (2603:1096:604:17f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 10:41:42 +0000
Received: from TY7PR01MB804852.jpnprd01.prod.outlook.com
 ([fe80::4c0d:ea93:5322:ee61]) by TY7PR01MB804852.jpnprd01.prod.outlook.com
 ([fe80::4c0d:ea93:5322:ee61%3]) with mapi id 15.21.0569.010; Sun, 1 Nov 2026
 10:41:42 +0000
From: Zou Jianqiang <jq.zou@outlook.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Helge Deller
 <deller@gmx.de>
CC: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "byu@xidian.edu.cn" <byu@xidian.edu.cn>, "25181214217@stu.xidian.edu.cn"
 <25181214217@stu.xidian.edu.cn>, ONE Zeroiser <zeroisere@outlook.com>
Subject: [PATCH] fbdev: radeonfb: reject a zero pixclock in
 radeonfb_check_var()
Thread-Topic: [PATCH] fbdev: radeonfb: reject a zero pixclock in
 radeonfb_check_var()
Thread-Index: AQHdae2VyPYCB5Gy402pFQiZY1Ht2A==
Date: Sun, 1 Nov 2026 10:41:42 +0000
Message-ID: <20261101104107.33909-1-jq.zou@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB804852:EE_|OS3PR01MB8778:EE_
x-ms-office365-filtering-correlation-id: dca00217-f73e-4ea5-0250-08df3804b7b8
x-microsoft-antispam: BCL:0;
 ARA:14566002|31061999003|15080799012|41001999006|39105399006|24021099003|38102599003|22121099003|12121999013|8062599012|8060799015|19110799012|4140399003|25010399006|26104999009|3412199025|440099028|102099032|40105399003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?xNVhB/VW/X0olUHVyMsnv1xgTurLYWBnTdy0AgrM5CGZxX1bUopfmjSN9M?=
 =?iso-8859-1?Q?R7Y1QZhwueL5RZfp3s2Wffu2yp0E3kBdpRy9Xwa0NTtyQYSomve4NpbIh/?=
 =?iso-8859-1?Q?YgqbvJU89wx8DsHg18MgJyqYOZOX0wCDJcujtrUn/09WCiFoZr1GWFN4I9?=
 =?iso-8859-1?Q?8f3tnh+85bPfLGvsdYDX9dkZTb/AEaYKX403e5MiwSixkakNNARHrCv+Bi?=
 =?iso-8859-1?Q?2qgNA3jx+2uNENdaPUoPSFJAcJxxQwpKY7LrKMXnike1WByzxozvpN2/0h?=
 =?iso-8859-1?Q?eKrd82vpcFekL1+A4fYMNnBchGsAMDbkwtXpsXMvzctQ7BQD8O7HUP5QOK?=
 =?iso-8859-1?Q?nWCCTmqkPGUv7uMiEo7jFt7mdHd7iUiWY5aH/dBDXW+g4UBoaO49rbwGz6?=
 =?iso-8859-1?Q?k1nFC45X+0pjaC4ZBgqbqWd67zBfcWbyHjx3QeobJ3gn/Rb0z2sB7fmKbu?=
 =?iso-8859-1?Q?dwO0IRtGCVfGFke1+1HYu1aKgs5MOQuQbx7BPDUP9JPBuJCH4FLJh+Daea?=
 =?iso-8859-1?Q?LxfbYzppwhFlK5Wu0lX0lQOVySel8TUS8aWhzXfy59r1FN5ik9XzcMQziM?=
 =?iso-8859-1?Q?cEfw9P/1xdm8txg5wJLVyLl8zqhr1lxl6nU2jpTFQPZKHTKtHhjOSAqwry?=
 =?iso-8859-1?Q?NCtFurobkwn9yuL5XJGHtqh29mRxZjbzgM7b7jaWJ17o40h871+Ju4jqK6?=
 =?iso-8859-1?Q?qgTwC3SliwcTJL6SAWDZOy92aq5Ijvo/lFy/o0xk12ylxCoBhgmMsAgsVK?=
 =?iso-8859-1?Q?YsKod7bhxeZCYh7JGP9Tu4rYTiLM/r636mafl6wT+MkaqovuUgYYqnD2o5?=
 =?iso-8859-1?Q?RxyCMuM/UNhQ/gP1UWAkboqDSufTjcwXgDmqBV+acM4lXtuoWX59X+zFPg?=
 =?iso-8859-1?Q?YZucbsX3IhIpI3vPV+3og7mJMAtCNByVfPevOqd7XLufzaC0axcMU2OmhT?=
 =?iso-8859-1?Q?cz7wSTZhGmHwTU05Xx6sSQpyw7Qc3f4aOLwKpEMGS/o6qi6bhyZvBkOgxe?=
 =?iso-8859-1?Q?BTBRFth/ouVWz5OVLoq8ORX8NhTVOmfLTAQ2FxTWPXi9gs+muJAe8gtf32?=
 =?iso-8859-1?Q?9lkfDNSjDqfyVYDScm0ieZ9uaD0kn1ddmG4lkwNKQ6Ab?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I9VOleJ5TJJepU6yzlSyw/PZvSDBVWpdb276fERe7DONs0t9BBe35jl1nX?=
 =?iso-8859-1?Q?+SB/aRSKHQl3v5wjTlQ+EYMr/vXYJoowUfTp5Z6yNDsSJ+uMnbffsL+efM?=
 =?iso-8859-1?Q?6O4BtpP2neo+TAAPEDYO234UdaLrAom+fzCuXnkj6yltmVaKWfJXE/WQXe?=
 =?iso-8859-1?Q?sYwjI0xPXTL/PXYOzVtoevRPklxZO8JZUTNTr/jQT+twJAlUGzvKGtC1lp?=
 =?iso-8859-1?Q?nMKbGGipSGUSoCz3GZCj9TB/I9So9/f7vICZ0CXnMe9qF12e3YUzxnU11g?=
 =?iso-8859-1?Q?V2WBRPWs9NLHX/tqvCwd+JCG8ChrRr049MlHQRW+RXpLr1cSi49i+XbGjp?=
 =?iso-8859-1?Q?OBwmUwQc3U3s2yvgjtzcqYAjXv7fcyeAqvRHR+zO8bm7Fhwb2hYCE6khvR?=
 =?iso-8859-1?Q?aQlS+jKkQ6rVcB2AnPKSwYW2ZY65iOqFx4RGtp+anc/R9pXQHv4xmDI5QR?=
 =?iso-8859-1?Q?UsfCtaJKSbz57hh2sPO4rkW9wVawE8za6jqNmteTbXwIWSneg32yB/VHNT?=
 =?iso-8859-1?Q?5SXShQynmEN+PeRN59HNrUSICDbfJaaDrjGTOjHg3PFGy4Dr6mWWkQzm+Z?=
 =?iso-8859-1?Q?cdB/mUMT9kn3HpCSsTTgl2+z4o6DQACTAO8XtgvUzq3LJ85XeOU97krz5j?=
 =?iso-8859-1?Q?AUfycrhDE1uSKNO4oFGWQ4JslDqD/2Erltl3OZLNPRSeKbRCmUdrte1+e6?=
 =?iso-8859-1?Q?4g8iUA93fs5gWp8rA9+jdweQbXG3+DqvBqhioNWGhV11gF9TZCKYDDuBmI?=
 =?iso-8859-1?Q?qpUtiZng4WVndu9IkO0xddJzikNFdRJhN3CjHFP6vKJGSW6a8a8uidL/Mn?=
 =?iso-8859-1?Q?WzYh3LyIqYdeWRsEFounprtK8GoLldiHIId29+GkKHXSO2dehvVrIQH/MQ?=
 =?iso-8859-1?Q?R//o5apX/ert7gnnIb0upQAxnmXZKOlBKCtSlj/QJ3ZlluHWPzmn7+5SXN?=
 =?iso-8859-1?Q?2hUg0lyxGTHH23fEn/SSD/HhRZgBSj1txxwkkH06MWHY2zF3tpDvOCsqaM?=
 =?iso-8859-1?Q?u/EERiwgMwmIYkpi46T2h8J8SPXJ6xA9TJslhoCJ5+Ztex3b7OHMG1DraW?=
 =?iso-8859-1?Q?6l6SFA+1cN+0n8astAI+XfvEF49zisX1GQ0zxcCPUmj5aQZrfNMLNbkoVV?=
 =?iso-8859-1?Q?OPs0IOV0AhOXBOUSkfs3JDUI/tAPIsDU1jr3Nd3tsN5g5Kop1Th5SiLwZD?=
 =?iso-8859-1?Q?9mNQZz9c0BAaGUQE9jPwUBMts8KOp7ZJSAXgBxm6fRUXxd0w8hEMpLLOB8?=
 =?iso-8859-1?Q?Tz0nNj7LYcVRgfGiYY0DWLlCmR+vL986bQG+GU7c70trqi/ANfb0WzJ9VD?=
 =?iso-8859-1?Q?GPbNYr10AZaO87rrHFDgAL2PHZWVUuqDIO0mtZc1KGbMFsw22VW39nML8B?=
 =?iso-8859-1?Q?uSiVzWcz+nGZZCe0gqRLybTOWU++WU3aNbgzhL2yhX6EX+PSiVgJO0tyNn?=
 =?iso-8859-1?Q?+QUT6wxl99O3DBLF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB804852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dca00217-f73e-4ea5-0250-08df3804b7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2026 10:41:42.2701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8778
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jianqiang Zou <jq.zou@outlook.com>=0A=
=0A=
radeonfb_set_par() derives the dot clock from the user supplied=0A=
struct fb_var_screeninfo:=0A=
=0A=
	dotClock =3D 1000000000 / pixClock;=0A=
=0A=
where pixClock is copied from mode->pixclock.  A zero pixclock=0A=
bypasses the existing validation and makes the kernel divide by zero=0A=
in radeonfb_set_par().=0A=
=0A=
The driver does have a check for this: fb_validate_mode() returns=0A=
-EINVAL when pixclock is 0, but radeon_match_mode() only calls it when=0A=
the output has no scaler and an EDID-derived mode database is=0A=
available:=0A=
=0A=
	if (has_rmx =3D=3D 0 && rinfo->mon1_modedb)=0A=
		if (fb_validate_mode(...))=0A=
			return -EINVAL;=0A=
=0A=
mon1_modedb is only filled in when an EDID is read, so when no=0A=
EDID-derived mode database is available the validation is skipped and=0A=
the invalid mode reaches radeonfb_set_par().=0A=
=0A=
Reject a zero pixclock in radeonfb_check_var() before matching the=0A=
mode.  fb_set_var() calls it on the FBIOPUT_VSCREENINFO path before=0A=
->fb_set_par(), so the invalid value is rejected before the mode is=0A=
applied.  This is the same check other fbdev drivers use (i740fb,=0A=
arkfb, s3fb).=0A=
=0A=
Reproduced on Linux 7.3.0 using a custom QEMU PCI stub device with=0A=
vendor/device ID 1002:5955; no physical Radeon hardware was used.  A=0A=
single FBIOPUT_VSCREENINFO with pixclock =3D 0 is enough to trigger the=0A=
divide error.=0A=
=0A=
Signed-off-by: Jianqiang Zou <jq.zou@outlook.com>=0A=
---=0A=
 drivers/video/fbdev/aty/radeon_base.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/at=
y/radeon_base.c=0A=
index b6b058cee..a69e58914 100644=0A=
--- a/drivers/video/fbdev/aty/radeon_base.c=0A=
+++ b/drivers/video/fbdev/aty/radeon_base.c=0A=
@@ -836,6 +836,9 @@ static int radeonfb_check_var (struct fb_var_screeninfo=
 *var, struct fb_info *in=0A=
         int nom, den;=0A=
 	unsigned int pitch;=0A=
 =0A=
+	if (!var->pixclock)=0A=
+		return -EINVAL;=0A=
+=0A=
 	if (radeon_match_mode(rinfo, &v, var))=0A=
 		return -EINVAL;=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=
