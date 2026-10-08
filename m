Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B3ECA601A
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DE210FEF8;
	Fri,  9 Oct 2026 07:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="YZnGtfNq";
	dkim-atps=neutral
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazolkn19010007.outbound.protection.outlook.com
 [52.103.73.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79B210FDA6;
 Thu,  8 Oct 2026 22:34:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp6ZIXYBrMH/ASxz903vzYYUDv7Bsrkeiee5RF8q+a3uLHwRithK/0uDjPf/Xv0P4j7aeUATsb1TG2RcrsXPeaNA75ZCirI8JGwUvn9wmeeHdtThxqc/ZSwOV0xvYTPokOpFfKhUr6pHymZVbvjJbQL+fNsRQz9W2E6IlspewOWPs+7D/uNhqqu0QEJ/WB7Nnaf4n/dZROTsY2LTNEB73ykxyFNsU+mZHjvS0LWr2AvA+JdEf4xyljdEaQoiCMv373JQd1308766GXiWvOKbihl6r1SSpGoa8NFjXucJjI/A9QsFKDRJvysU2EQ2sZICrw+2hFcWmSRgJ9L82ci2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax9UvyFavi/xBxMij5FT+p1O4eUE9cHFgeXf+/OULjU=;
 b=KJjy02UuUrgHNuczPSkx+H5ZeWqxx1wfQAqZJiFpxG+SZXVqy+KSo4s9kykordgha3rFvPKa4U3ObcShx1on2BFGRs0GGQCHjZNDqruk96hlT5SXRkUYe6JUitAHIKIZe0lr6fFFAD+v2Og/FKg84EDnKJjk8OVsJttoPBWmNx4gn353lbAsu8iUr91/dkxjS+CPribRVrZpxZ+t9t+EkN0wI+x7MkF+QUNOws0v3sjducfOh5U+CQ0Wj9Aisl4a1WB7wwn1A3uD/TkpVowKxDNEYc5UAfATHi4AJ5a9LRyq+ZFwGc8GQiQRbwiS0As2YUMbRlF62tKrQXGsoSBlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax9UvyFavi/xBxMij5FT+p1O4eUE9cHFgeXf+/OULjU=;
 b=YZnGtfNqHSUGiUu7CLPhljZds50asJw0QN2+6d/k6Sy0NbwF0XniYGhNaAPTIJAFVaeL7nDiviZ5+9pL7JWJMi9ZfrFDE38RyZsJxq3jOETdt5NSxqxon9cpYxomQ2nqdcSeAn6TVXbgu19qr7SQDHbGt6Dp5T5vO/EG7ZKvLBxMAvT6o8HOrayavHuJP/+we0VZwXSKyxiRwRlTdWe/1dFe4VVc/oNKEGioa4VNgVNuLNZhTHqlksJ/SSYxfgkg/UU0wcuFPUkr87KEsiL+d0HkR2PgN4nisAgCDu2A2TLDZ1ycL9H5exVXgoZJCC8PM1CNXKt6apoWarv40q1MiA==
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com (2603:10c6:10:32c::14)
 by SY3PPF346C5784E.ausprd01.prod.outlook.com (2603:10c6:18::40d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Thu, 8 Oct 2026
 22:34:51 +0000
Received: from SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19]) by SY5PR01MB10600.ausprd01.prod.outlook.com
 ([fe80::db5f:2818:b791:cc19%3]) with mapi id 15.21.0522.002; Thu, 8 Oct 2026
 22:34:51 +0000
From: Zhang Jiaxi <Z1529105815@outlook.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>
CC: Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, "linux-arm-msm@vger.kernel.org"
 <linux-arm-msm@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "freedreno@lists.freedesktop.org"
 <freedreno@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/3] drm/msm: keep the commit vblank reference through
 completion
Thread-Topic: [RFC PATCH 2/3] drm/msm: keep the commit vblank reference
 through completion
Thread-Index: AQHdV3U74YrpLwuY9kaDASpRDvfFWA==
Date: Thu, 8 Oct 2026 22:34:51 +0000
Message-ID: <SY5PR01MB106007D885AFCA2DB1C92BD00A1932@SY5PR01MB10600.ausprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY5PR01MB10600:EE_|SY3PPF346C5784E:EE_
x-ms-office365-filtering-correlation-id: 5571b5d1-777f-4470-49cc-08df258c5e5d
x-microsoft-antispam: BCL:0;
 ARA:14566002|51005399006|8062599012|19110799012|31061999003|8060799015|25010399006|25031999004|12121999013|704163111799003|15080799012|41001999006|2604032031799003|38102599003|24021099003|16051099003|102099032|2607281247196008|440099028|26104999009|3412199025|40105399003;
x-microsoft-antispam-message-info: =?us-ascii?Q?9oGht4tSux9j46ES+ugqbfGuZ/5Z1OLcaktET+weJEoWYuOe+uukxUPG4WPm?=
 =?us-ascii?Q?4GMloTgFUc+o7P2NYFXyUbkAHTPS0fWWIKwqXHP1tIBDKIL+p77gBtBGypd5?=
 =?us-ascii?Q?qdTzggQDv1E2gBnUhItEU2lQlkfXXircwSIfRxtyDPcOEzwQ6CamoyfJ3BRv?=
 =?us-ascii?Q?Sv5CiDzvq5ZO/qkBj4rMIMb7N4483FXbLCl2FtKidgApEMbGgpdoJsmoCxiP?=
 =?us-ascii?Q?ToS+jO0kDL/4Vszk6mpiEjebKRDEWFdybp26pcnW8UQBt8Yub0txXT74qfBA?=
 =?us-ascii?Q?Wc5iJXxCn74dIuTOfIb2tHcpI0mavjZ8Vj1qB0TfTsz2GPEY31fIurKXBUJN?=
 =?us-ascii?Q?zu289Al/ktdhdFkws6/kH6doOtSWeUYTrctsl0ArKFw9sJFGve8Ox93/OZJ5?=
 =?us-ascii?Q?aMpdHW00fGQPGoL8WNsJP3VoPIYltENm6CM+r1V+rJLrCxZsVztT/Q9E9qbs?=
 =?us-ascii?Q?uxrerVA7QZAXYLZPkvroLxaDO0w04Wd/AT6cB8yBrc7kHPVis1wLRsreNsLH?=
 =?us-ascii?Q?u+A1lU86elYctDELa4EZ1D2s2anO7vX31zKkrkZINMKZ6b5NQt02567yPEt3?=
 =?us-ascii?Q?+hCNPboUjf+Lg0cXOrhEcI39rqbbo62hds1DxL4l7UpAvrtiJpKBMsZKkhGf?=
 =?us-ascii?Q?kbschA/14Vn4dMUA9yhtmONsjGKhpgjocXVFJNNGbNzOOkIkG+iN4vkBG/v1?=
 =?us-ascii?Q?/J7eFqNe+h4so2FZgesl8gLF1PMp90RGSgQv37JGdZK+4IckAhtyKiHcEnWt?=
 =?us-ascii?Q?M8+rDEM8JDEL6tRGfHgQVDBpwniOTwmWlutkTKZ8PnNl+YEB8eU0iz/uKcYr?=
 =?us-ascii?Q?/3hxVu8IjrJM67jVrJTKROs2d0BSQ3tIyEFv9DYE3JrWY5iNWPA5x74l9PMh?=
 =?us-ascii?Q?jGNcwFJcNlCxjWVH076TV5njHjh2AJsiJxyHaWQYgRKrRgaUJRW+vn9OvE6j?=
 =?us-ascii?Q?8T2vfLwRgspAmAdR58Wj/xm2UbNiC0odpSsScFVHeCY68bqYFvRTTM/9yG9y?=
 =?us-ascii?Q?SgvM2F+zfoKv/6xZzxcMrp3gsbx7maTS/X27KQLLXpdz/FE1nZLbY7GPib/Y?=
 =?us-ascii?Q?orU2sDHbSsFF3BSJRBEhuJE94IIJzFkVA/SAimaf59LloTVDoWoRUbmwDVZx?=
 =?us-ascii?Q?BvL91Ua0RXz55VsLTCaJpS6GFpheTxnuaIdPjGKv95CzQ25SfAC6sTA7FkoU?=
 =?us-ascii?Q?+Ub7VN/j8Eg2k75o?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MK0i0l/RhlFjIS3YwUNW4AzGgs7ExAZ6Yzhehro67G+MGBiSYRmS5b3/2uHc?=
 =?us-ascii?Q?fyvkmDThU4/3sVY0HtFiID2I81Yp9q3z50aSwFCEy3/dV3KoF1piUgJ7IPFg?=
 =?us-ascii?Q?OapAH34GGNhd+CjNAMFiIyAD+EoCENcbqIHSr2H5KgqMIJjVf9ZID4u4IGnL?=
 =?us-ascii?Q?h2TqL1g1qbWu4C75EzWj+bh6pPBQsz5dOBHtM10Qw12situb79WpAq0nNuc+?=
 =?us-ascii?Q?MIjRS4H61kZMzTO02Ya9TxKaIfmTYBBgsm2DrPqg0IX8Q3WFWjhMKKUs9d5b?=
 =?us-ascii?Q?7knNo6gb1yC9CxNak4wPnX1JFW2iV/noCpqDrCh3/MB2qXH08cM9wtKMofgJ?=
 =?us-ascii?Q?I2gsDWLh1HZvgYIl/ocig3SIQ77BG5iFrCZLP0FFwOYjBwlCGevMmJTQSZ/k?=
 =?us-ascii?Q?coK8vanMADXNOnte1cjA4pbxoF8Pfi9+95qTv/ivq4PiMGOt+vUP24Q5Tibn?=
 =?us-ascii?Q?Gwzn1xQAvDL2+EUqzP/MLPaZt1USIOw1E3tyozRaDvR20VG0n48p7no/QK4d?=
 =?us-ascii?Q?Y5ryaD+OUN9E5bzqAde/ggW7AzfGAIH8/KmgKNHl5HgAlCdjd5FQwcGbym8U?=
 =?us-ascii?Q?TS0fylr4K0L6oPXvwQDtTTGTWLo8E9WlAZyt9mYoytaMDaTbpe0IF4xVrG5Q?=
 =?us-ascii?Q?s1o+n3bf+4z4rC2nh0CbZmAOXdHA15CW/5O8bAvLdet7Pk/lWGOwycTM73kX?=
 =?us-ascii?Q?BWvFhDPXFRVqiXMKf0JRtrFngDlrCXFiAu6tzs9deFTXbVztl82QqYKcezBD?=
 =?us-ascii?Q?wJF1e80duvkB7qlb9RDjylC1aPauk4fl4sB5NIPVPzVY/zNacOVyVc2+7iXP?=
 =?us-ascii?Q?UvOxnzMGK4Sa2hucI734oDJj5I+5una/L2cFwYfkv25mNv6CFVP4FaMOS9DJ?=
 =?us-ascii?Q?bBg0JQ7GAeknSZNRWwp0SfLOzcFMXhx8l5tu4y50LdnrcOz/I4rbVmLbSqfm?=
 =?us-ascii?Q?0+wEQqc0VvF++ylhDySJFVeRtusjKkbT/53rwd9PZ3bJNgWSOVom+c9z0/Zl?=
 =?us-ascii?Q?1w92WSQRQxBF23axcbwJtpCi0zyA3yZ/5xcBRUxw90wGCkqrmqGdzrhDQRYi?=
 =?us-ascii?Q?nYD82tVbZR+Y3f3UGq8HDbguAg1A+SjiBQ9Q2lx2Ddd4E47ySnMh3LU2VAD8?=
 =?us-ascii?Q?1lFyvbv78EdsODpu0937ae28dWnLiS0OTonYmNmuGarp5XbT+ZwJzs/wqGxi?=
 =?us-ascii?Q?SFsPHl9Wnr/57n+yOHrF0xaQFmzkBb9ZXIj2Yy75k7oM1DGVPQN9qDW5yZ+q?=
 =?us-ascii?Q?MwNwxrB09/k53CbHJScV9WbzFza9gS4IjORqkrnPeoXH8QYJuFeEb8c5r+eo?=
 =?us-ascii?Q?+1Su4IVMEc2u30980Vpp+qUU/4EYC/+8vKiVXPgRRKRp5xUIc2aKmDIDpzJL?=
 =?us-ascii?Q?BIXSE+KDpP4UO8rg2pQkJbxxhH7M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY5PR01MB10600.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5571b5d1-777f-4470-49cc-08df258c5e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2026 22:34:51.1658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF346C5784E
X-Mailman-Approved-At: Fri, 09 Oct 2026 07:17:39 +0000
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

From: Jiaxi Zhang <z1529105815@outlook.com>=0A=
=0A=
The synchronous and async commit paths acquire a vblank reference before=0A=
flush, then release it before calling complete_commit. The DPU completion=
=0A=
callback reaches dpu_crtc_complete_commit and _dpu_crtc_complete_flip, whic=
h=0A=
sends the pending page-flip event with drm_crtc_send_vblank_event. That=0A=
function consumes the vblank counter and timestamp.=0A=
=0A=
Release the commit's reference after the completion callback returns.=0A=
There is then no zero-reference interval between the commit's wait_flush=0A=
and its remaining event delivery. This matters when immediate vblank=0A=
IRQ disabling is enabled. Keep the existing enable_commit/disable_commit=0A=
clock lifetime and CRTC locking, in both commit paths; no callback or wait=
=0A=
is moved outside that lifetime.=0A=
=0A=
This is a reference-lifetime correction, not an assertion that completion=
=0A=
waits for another TE interrupt. It does not impose an always-on IRQ policy=
=0A=
or change the encoder's transfer-completion mechanism.=0A=
=0A=
Signed-off-by: Jiaxi Zhang <z1529105815@outlook.com>=0A=
=0A=
---=0A=
diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_ato=
mic.c=0A=
--- a/drivers/gpu/drm/msm/msm_atomic.c=0A=
+++ b/drivers/gpu/drm/msm/msm_atomic.c=0A=
@@ -91,9 +91,8 @@=0A=
 	kms->funcs->wait_flush(kms, crtc_mask);=0A=
 	trace_msm_atomic_wait_flush_finish(crtc_mask);=0A=
 =0A=
+	kms->funcs->complete_commit(kms, crtc_mask);=0A=
 	vblank_put(kms, crtc_mask);=0A=
-=0A=
-	kms->funcs->complete_commit(kms, crtc_mask);=0A=
 	unlock_crtcs(kms, crtc_mask);=0A=
 	kms->funcs->disable_commit(kms);=0A=
 =0A=
@@ -310,10 +309,9 @@=0A=
 	kms->funcs->wait_flush(kms, crtc_mask);=0A=
 	trace_msm_atomic_wait_flush_finish(crtc_mask);=0A=
 =0A=
-	vblank_put(kms, crtc_mask);=0A=
-=0A=
 	lock_crtcs(kms, crtc_mask);=0A=
 	kms->funcs->complete_commit(kms, crtc_mask);=0A=
+	vblank_put(kms, crtc_mask);=0A=
 	unlock_crtcs(kms, crtc_mask);=0A=
 	kms->funcs->disable_commit(kms);=0A=
 =0A=
