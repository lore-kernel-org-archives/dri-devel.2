Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64428C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD97910E48E;
	Tue, 22 Sep 2026 15:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="WsYmqPZ1";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazolkn19011029.outbound.protection.outlook.com
 [52.103.39.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B720E10E48E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 15:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUPd/W7GNnrHGR+YdXarUvviChW8Q4B9nWHfHNXL1wyPoHfMg5+QSSYgcWu93TCbYxDUHs3Sp8q0YOKSC95mXAbtOg8vVmXrBpfkSPaUSAwTwrZK3RrGJ081Utt2/1ReLkCZvSEiEmRgkSi2QKVJjq9T2SRVT8ZE42rwH6pxvKMe9lRaEWqNC0KPPaxyTZHOG1+s2FNDyT3noJBO3AZhyEi+QpB+YviOnlPfKMU61oNarJmMDYceruV8krzQiZkIqmHyuNUbl5AtAXSDM6s826KLeKAgmgKoWvf2N45/vNTHegj20fHktFXezuI0qqq8F2LYtzyhSnyAqW2vJS6NJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EODjy02mOSJInSi6b1rNgHg7hdRQMuom7JgM3v6y3DQ=;
 b=xa+87YSeYSBFBnxn5EaRYwdFrm4MfOjauR6oEGVALVfGjkBZ1QfpfwEB5XznREvyCG0+iGh/cKVD7VU2pbqI59jAgQU+z4Df8iY0+yL5BUE/wwOLpBdc2213XxRGz3Qz7zYvhcrFtNpSPS3jxm7gSSVkEFXyelIUaKa708cGvNdrAyIhxq2W4Y9lOr+DoR8sN/T3NF3W1i0vXfvoJPM0QJ8sESmKZ7DhKbrVD6SJ9zF4gL6x+J32JP6YyOcH7rg5X/yst7x4HV1asnI1UUHXkRAbNqv6B0H6P2wdiYyC0fkUzi8ROLzGpMLZLsgZ6UlW6agGca2KS8AkNNJ1qHRcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EODjy02mOSJInSi6b1rNgHg7hdRQMuom7JgM3v6y3DQ=;
 b=WsYmqPZ1XVg4MxRjoAy+94RBNeBfa7XDg2bWg5PPQbWxtjFc78Gj0ryzWE3M+myy7gUw9aq58ddMfKZhNOu+DpxjtFsgpVzi/25HzMRyxNDvMY7wihiXJao8vClBdGh5Zu4fm1G6nqVDpW+YPZPg4wxjk/kR+7S8e+su4KFoJlfRaS7hPVjhYn+FVOf4I7lhTLPAQuJjU0g817DTYON4bAeLrHzso6jKfXoG0jKxKuJMjLiAUm93vuz7devpCwYmonKU21zgVedUGAPVT9IQFTg/9PHV+Oj3LA3z4JZbtsnIx0+0x+hG6moaF7UdK8Yp0datcsFgaTpjQfR4eRTUFg==
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com (2603:10a6:10:223::18)
 by AS2PR03MB8868.eurprd03.prod.outlook.com (2603:10a6:20b:557::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 15:48:35 +0000
Received: from DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48]) by DB9PR03MB7388.eurprd03.prod.outlook.com
 ([fe80::2ce4:f394:cc5e:6d48%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 15:48:35 +0000
From: Arthur Liberman <arthur_liberman@hotmail.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/display: fix NULL deref in MST time slot release
Thread-Topic: [PATCH] drm/display: fix NULL deref in MST time slot release
Thread-Index: AQHdSqkMHX7Ogigfvki59pOhoo8P/w==
Date: Tue, 22 Sep 2026 15:48:35 +0000
Message-ID: <DB9PR03MB73882B683E0F81D7E97581228A832@DB9PR03MB7388.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR03MB7388:EE_|AS2PR03MB8868:EE_
x-ms-office365-filtering-correlation-id: 8ccdcf6c-0ec3-4c13-eeea-08df18c0f64d
x-ms-exchange-slblob-mailprops: znQPCv1HvwUXBahuwteIkQeW30lJPuxOsRDk/H0rA4HJGL9xZRU/oOVi/yFwA3mhZ1XHeeV4wjAL0imbrRSXKN5tOtiUFvuUHPuewP/EVTenne7dOrfGfw+ymZPfoCdwoIbFxtAfnTxre6rAM25qXK1gA8sCSOW0hS06jxQAoB7bs37ILa0P2HFm0IlXVOsPTLHwab9PHtl5wcpuk1oVh4dasjp+ZziyNZ8/oBn5Dd/xN3cnHy/n8eQqDSoxHPWaeWscDJpPvNYZLD/TqN4wV01PEZzrvAK3ss54A8Pye75Os/fdHUAoDvwGCANoT1ai4AOgtSQep/LwoLFehPjybgfb9S2eOM6hEXX8MLQKEz2cRJxcEZ62i870W062XfhP7GHrvvZT2KAfGXzbWUi6bsG8VZuyT5xwv46VNgsnPdUz0OpdfplRdnW022OgTabQLLka71IdPjeWztCUEXxB1OnHOaWnHw8pjS7mw2/7a5jJ6SDgKAjhorbxr8wBNILSBosTXgBDwXe+Ud48hBNzk0yCLzyGkA8Y4Mi6iPqoI8XglrVWrYhTyJQhzqKwZaOu1LlRHwlvbgGS8H7od6ORba+3lGHKqAYtob25q+jQpKS6v9NcVIwTqGUyLtGgUN5xdHkULdUHhgf1lK0/K7WIGAf0HDQUDxsoD3IhS+ycSpePPmVakzal9cpmKtDjhX5y0JtaZoUmFG1HT9iPZ7jJjBld+RYIZvGMFjYiFQi6HGAl/Sy3O7t9zVU6EPhcKcmn5ccOtYMOYxU=
x-microsoft-antispam: BCL:0;
 ARA:14566002|25010399006|39105399006|20031999006|4140399003|37011999003|7071999006|15080799012|8062599012|12121999013|19110799012|8060799015|31061999003|15030799006|24021099003|41001999006|5062599005|40105399003|2607281247196008|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?E7zsda5B9dGXHSeiWkfxakKRQh9391oF3M0JwRt7eOfV88PNBqfMys+sJg?=
 =?iso-8859-1?Q?6tGoaiwIkKbPNBsTlEy2vlmPjofBE7m2oPWiCJIDpeRKCfZJdbSkECUaCS?=
 =?iso-8859-1?Q?Tvqm/81T/VmoI84GxotbujCY4KVoD7Vz47i7aFIKU4QvbyxcnxNqzjfkWd?=
 =?iso-8859-1?Q?viBLrFH7KA/9Vw7+JRFm/9oYxxbbO411OcitykuYT1CbxVdYbNqNiqdU+T?=
 =?iso-8859-1?Q?X6D8B1qqpBrx6B4WzD6pENVbcbtkWHHeJksuOSwYhfvm0O9oSkY+o9rf4h?=
 =?iso-8859-1?Q?QvCCb1QgylDNmfDqv21d51GI+TREamD2OHIO4jyGHuHi1UNmXap6Xrm752?=
 =?iso-8859-1?Q?XaknZRA8VVYWDh/qkuaRDZ+nPQlcsKvqrCqUCgTL3Voj+4/X9KhV12JpAo?=
 =?iso-8859-1?Q?VZp0EC9y/KwpnDtIciCNiR3m6jd9pYRKmzLd20CLbsfyUyeHHLNFYW7587?=
 =?iso-8859-1?Q?8PfCo8TVlFjwgWjFSTTIPIlejhXif8yPP9DykhAdQm/DhKXDYPetlZBFcV?=
 =?iso-8859-1?Q?wG4i/y0BNyWoFkeNqf6fAKQPW4RPpcdMFTgCiGd1tP7V1GydsWL5sVFh3B?=
 =?iso-8859-1?Q?lM7GmbFe7vxnz1vElqC5Zx+uOFYcgaDVGwL3EI2uBz4QjA70uNped6rtaS?=
 =?iso-8859-1?Q?luysMuJIzxG9ywkl8hZl9bRag//FKBvKGSb/M9n8RYcmPMLR6geB+6xudc?=
 =?iso-8859-1?Q?ZoqzDEEYl3FAXgdv5lDAfrWIGbuXk2D54wt9CVGx3FOz7I6qqFlBzL44Mt?=
 =?iso-8859-1?Q?sJfZE6WAAMRVXO/iVn7YNMVvvbnkMDfZ5QELUHeKLhR1/14X/EeO6LtXW1?=
 =?iso-8859-1?Q?4Eki7ZqrqFx+zoDI6pG7KWxsI1bGXd+wnB/7urgfvbgf0F8fxE0TjCrNgT?=
 =?iso-8859-1?Q?qJFDf6YN96nQIu72dKLPbCxGecD2hS2EOEqujCql/syIz21hWEsDyWUNdm?=
 =?iso-8859-1?Q?4PaW57hzdMN9CWnnfLx035EHipGlnmK0z+AAFZDYdH2lYH9j445ZoAPsl9?=
 =?iso-8859-1?Q?GzCcKBgvbLbO/OEK7AWNRVLl0G2VqvfK4CxvXaXwljZFZdqZkDEY2PUs5R?=
 =?iso-8859-1?Q?Tk4hgYNjBoxrBff0kvK2CFm5hU+e/aNnnVvEd2U334gS26PcD1jhLAm5eL?=
 =?iso-8859-1?Q?Jtly8Z8JwRVUOiTFVUFatOYg5FHph6GjbTedBRewMBKkes1dKiGzBEfP1u?=
 =?iso-8859-1?Q?Ol6L4KTO6hthvQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wZ99eTpNWQYpf7ng+rYwUnhn2QGmDRJfIUfmvSXz0MN3/ON7/giei2nGTP?=
 =?iso-8859-1?Q?fIuzAHdU1qMYahazsU8VhmmYs8n+MqjWTI06NzaSEUNmiIovvQhIg06CqJ?=
 =?iso-8859-1?Q?rY7RpkQKpxDdu7qjGUZPfDw1sHl0uoYX0Vm4wIHtJ6hMJeZXa6EQaBgiZg?=
 =?iso-8859-1?Q?Jyx6RuxTi0dKsros9T7Qmt5gLzUWYKDmgfj1CiYBBXEHuIZGMFMQf13nc0?=
 =?iso-8859-1?Q?H90yhrxUZl7e8ZTjmOJoZTQ5PLzC7v3vTCGN7276RfcFBNPtS9tkv813oS?=
 =?iso-8859-1?Q?1a51qgldrdWFaJnPLvJZ0sj3kgyyebLYtSs08Z8LbfNdi0AnrugccdLvD1?=
 =?iso-8859-1?Q?KPLCL+dCv91oTvTbguMQt7wh5/xoVFXtcwlCBVmIrsZf/krPPNq42kQzZ1?=
 =?iso-8859-1?Q?zW0rp+FLlp3aQaOfOfyUxoD2Z43bRtLYAcFRBYVZjD27MvASYdSPchK9VO?=
 =?iso-8859-1?Q?lgorzZpaXIaZ6D75YlEdNbuC7FTShtXeiWKQDjOjw38NTMk1bl4uYHObw/?=
 =?iso-8859-1?Q?gOQPLJOEjvqxWE8lcAOn5yOJ7ABF6xLtLdriKYTS/mNCJu76+tSSL142Dr?=
 =?iso-8859-1?Q?h7b5J740rIXxlQ7562684utSTBxO+CUizVFVx52BfnnidEWfXlf+/QfT5A?=
 =?iso-8859-1?Q?736FtgwMexVfWt1EzLw6Me/iL64mU4yFBPnP8WpdGmEE0ZCr5+z1XtPk9n?=
 =?iso-8859-1?Q?XJ4LF97Ev1glXjwsHzowrtB0a7/6Vzvye3ZlgmzEJhf7ubOs9y2jQ4HdEd?=
 =?iso-8859-1?Q?Mg/6nWXANXDxdMADTAQcVmnJHsCe+Kjjqy1p5J8Ws3LiF0d8/HsHQvjHGf?=
 =?iso-8859-1?Q?tVSf1qc+qhRkZWe/b1qMr7p6Zj1X0oe0xE0/NMIvyF1ECC5tGSVV84xQju?=
 =?iso-8859-1?Q?+zzOXL5a2Y50BXaBxWBJ0t909bC0g599fEpeK29GAUTbz2aM4eMzZE7Q/c?=
 =?iso-8859-1?Q?whODE7hYkELZGXHq3r2mwPgX6X/w4j/j+Co2WQh5LXnekw3Ft9uh+Xfntn?=
 =?iso-8859-1?Q?k+tDrMYb/B8k8MKg6zzhH7bAZwRMzlTmF5u2dVevXIDJAlk2mA+mdpk9aH?=
 =?iso-8859-1?Q?gqQC2eeuO9mPTFtijsGhlNSR47WkHeDEKF42chc3Hc3aVlSq9PyaGV8Ucf?=
 =?iso-8859-1?Q?mWlOG8HbGEqJq3QSy7Rcd/5mED2FAqc8nBPKLDT5pH7ZDDcmOdfhtItUBd?=
 =?iso-8859-1?Q?gZBbRp6QXltNWe0nXiySo7lL0NJ/hFeyQTTIfe7wExFHrszNDo8tczQkno?=
 =?iso-8859-1?Q?Ga1YxFMnWetk+3kLe/CByKJ+N0tRLu9pj7M/jAEAgnfh5FXvsxSh8++op4?=
 =?iso-8859-1?Q?iy2e5bsQdjGN4f3yahSFAA8BPSmDm2NxZxUKt1Q0ITqbOm6+gKSr6mQ4l6?=
 =?iso-8859-1?Q?wlScG7CLZdhmPcso0dgn0igM+f9H/12pBYO6PKEge9mA8JJClKlvpmOJpU?=
 =?iso-8859-1?Q?GzVFPP+xTjAynOEM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-6-msonline-outlook-24844.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7388.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccdcf6c-0ec3-4c13-eeea-08df18c0f64d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 15:48:35.4464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB8868
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

From 3252a2098213f539a17de92a7b7af11461d0c5c5 Mon Sep 17 00:00:00 2001=0A=
Message-ID: <3252a2098213f539a17de92a7b7af11461d0c5c5.1790085016.git.arthur=
_liberman@hotmail.com>=0A=
From: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
Date: Mon, 21 Sep 2026 16:36:47 +0300=0A=
Subject: [PATCH] drm/display: fix NULL deref in MST time slot release=0A=
=0A=
drm_dp_atomic_release_time_slots() is documented as safe to call after=0A=
the MST port is gone. After topology teardown or reprobe (unplug,=0A=
start/stop TM), port or port->connector can be NULL. Atomic check then=0A=
oopses from kwin_wayland:=0A=
=0A=
  RIP: drm_dp_atomic_release_time_slots=0A=
  CR2: 0x80=0A=
=0A=
Return 0 if port or port->connector is NULL, and if the old or new=0A=
connector state is missing.=0A=
=0A=
Fixes: a5c2c0d164e9 ("drm/display/dp_mst: Add nonblocking helpers for DP MS=
T")=0A=
Cc: stable@vger.kernel.org=0A=
Assisted-by: Cursor:xai-grok-4.6=0A=
Signed-off-by: Arthur Liberman <arthur_liberman@hotmail.com>=0A=
---=0A=
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 13 ++++++++++++-=0A=
 1 file changed, 12 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/dr=
m/display/drm_dp_mst_topology.c=0A=
index 7ce9e212770a..31b30706cda3 100644=0A=
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c=0A=
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c=0A=
@@ -4536,12 +4536,23 @@ int drm_dp_atomic_release_time_slots(struct drm_ato=
mic_commit *state,=0A=
 	struct drm_connector_state *old_conn_state, *new_conn_state;=0A=
 	bool update_payload =3D true;=0A=
 =0A=
+	/*=0A=
+	 * Port may outlive its DRM connector across MST teardown/reprobe=0A=
+	 * (unplug, topology restart). The helper is documented as safe to=0A=
+	 * call in that case.=0A=
+	 */=0A=
+	if (!port || !port->connector)=0A=
+		return 0;=0A=
+=0A=
 	old_conn_state =3D drm_atomic_get_old_connector_state(state, port->connec=
tor);=0A=
-	if (!old_conn_state->crtc)=0A=
+	if (!old_conn_state || !old_conn_state->crtc)=0A=
 		return 0;=0A=
 =0A=
 	/* If the CRTC isn't disabled by this state, don't release it's payload *=
/=0A=
 	new_conn_state =3D drm_atomic_get_new_connector_state(state, port->connec=
tor);=0A=
+	if (!new_conn_state)=0A=
+		return 0;=0A=
+=0A=
 	if (new_conn_state->crtc) {=0A=
 		struct drm_crtc_state *crtc_state =3D=0A=
 			drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);=0A=
=0A=
base-commit: 8a43738e56d9eb76a573cabab4c9c0e73eab23b2=0A=
-- =0A=
2.55.0=0A=
=0A=
