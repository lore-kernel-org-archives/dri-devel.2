Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C451FD58B17
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 11:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBFA10E232;
	Sun, 15 Mar 2026 11:20:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="rpEAal92";
	dkim-atps=neutral
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn19013078.outbound.protection.outlook.com [52.103.43.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2F210E179;
 Fri, 13 Mar 2026 15:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFv4riX73ZbnzNXiQK0kZc99IZApvOP29YUB979Sd20VuRnI/fgihtvJsNJrpT4EXL/fiLzQfTk5csXM1S+aqVFQICHjNdylfsqpa7YMyJl9c/f2FmW/c7B8hrdT4f0RW5BNk1otG2x+5fOqB+rAB7Xjs2plrqmM0p9/o2z+shhPS35jndMqZ5Uei2DJrxG2YVQ9tK0Q5NNKkc0gQGgXikEjt8zWyc6Th/6wt+Ky+3K3JN5kZcxINkyBXpDGvEP4cja9WN4A8vmpnqIPmZ2EBhSKdqzwVnTn25CPVuMhlEDvtQz6sp4K0zBQouBh331JX6QaM3JUvrFWwWP19cdarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7BZUCuOJx41yQeZyG46SsSwCxOGOPDD1N01Rn2DD/8=;
 b=U5SpFAAJVbFxJ7u0HB3s48QkFDvyAehLEVORykENmTxHEoFWTBLUnNQuSTl9gfw4D5wIqQz8cE1TKulDRvokPD7cMewLmOoLBY47Rd9zbpIfCJ/fzVjcO5TWhPFHW7mTJWpklUGYNsTvtImcekD4k5Tl7/h8VMrCtYuLxK+NDCnDv5aRsEOscgnkrBBM9B6j7407SfcCp3RJz/cmYoqHSTgJqomqLbJYPYXKsTNAtYFKBcbRC+Q4tw7R5rQ26SNSDyJYLB7qIsi/1vFNqi0WMM8gIIiiUWFXKgOiCB88SZkKS2SXE4CAO+tA9ZNgeZqvY1fLuZ9hainHHZ3B9FJPNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7BZUCuOJx41yQeZyG46SsSwCxOGOPDD1N01Rn2DD/8=;
 b=rpEAal92I0bsjWpi1lJGdFtzQT0RdQvUNjr3xHZqPX3yNHLiHTxqniV/o1wuM+l2aVME6R1S/CqCqy5pISgL6k3Y+MT0fPRAYoWfIYHT47Pl6xbQe87TUQ4WoyC09tnZa73LsyqGrBjVi+1zbIna82VV5LUGfjEDiLn3CXyVD969Fc1pUa/LB7+9InlDZ2uJFM0ID02MRuIacZCxIGFXlkKxk/yilzJzH8ZhBtvS+5/rylJMjcBQy9GPsz6384i5TH12q13attlZr/nKI2uhErwhXJYRT83/z6Pp4TK3x6IOnS2gx4nkxuxqVfnWq/f49XdwtXHXSaazTCPZ8yGWgQ==
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com (2603:1096:d10:5a::6)
 by KL1PR04MB7254.apcprd04.prod.outlook.com (2603:1096:820:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 15:14:14 +0000
Received: from KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::c938:f5bf:d734:436f]) by KUZPR04MB9265.apcprd04.prod.outlook.com
 ([fe80::c938:f5bf:d734:436f%4]) with mapi id 15.20.9700.015; Fri, 13 Mar 2026
 15:14:14 +0000
From: Zhang Zhenzhe <zhenzhe.zhang@outlook.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Austin Zheng <austin.zheng@amd.com>, Jun Lei
 <jun.lei@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Increase DCN314 SR latency by 1us
Thread-Topic: [PATCH] drm/amd/display: Increase DCN314 SR latency by 1us
Thread-Index: AQHcsvuFzeiUQFQOEEa7ePJTe6Ab+A==
Date: Fri, 13 Mar 2026 15:14:14 +0000
Message-ID: <KUZPR04MB9265F4DDEF7627D2E3747BBBE645A@KUZPR04MB9265.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZPR04MB9265:EE_|KL1PR04MB7254:EE_
x-ms-office365-filtering-correlation-id: acdc86dc-edd9-427c-9ae2-08de81132feb
x-microsoft-antispam: BCL:0;
 ARA:14566002|7071999006|22091999003|24121999003|31061999003|39105399006|24071999003|55001999003|20031999003|8060799015|19110799012|461199028|15080799012|15030799006|8062599012|1602099012|41105399003|40105399003|3412199025|4302099013|440099028|10035399007|102099032|3430499032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?x/Zm7IeqVyBuXPEvU0DsXkZW/80cej66hukTpnq5mA11xUGzS+MawGdQEe?=
 =?iso-8859-1?Q?P5dZVxpOkgILi6TcZwIvm+2QTfYVzLG0JffIp3zO1srdKznvgAtfymn2/m?=
 =?iso-8859-1?Q?ZTeq03gUZmZ90cmKH0IOnh5VXk+dj52X3b3NYmOaMGvLm/RVyJKiwWrPSm?=
 =?iso-8859-1?Q?m+Pr1s/m00GmvlQVlg+5DNzJWRCfidEjuGnsKnQEVhdOGRMnHmOAc+dQl5?=
 =?iso-8859-1?Q?5CvINCts0iH3r/Y8Mph1ZVBP7o7T6O1/H/egNNfA/s5YfiQFxQ7xgxC9ea?=
 =?iso-8859-1?Q?EoKKTG+dqqKDs9VUzUddWAjQnmVlzCTNc2miQ56YFFcONm6Mrd8gV1pFqZ?=
 =?iso-8859-1?Q?Leku0PN8HMdhZT+Olbuzw3B71TdkisGNzY4prbWxl/Ka/KoiOuFpycykJ0?=
 =?iso-8859-1?Q?jDU+zbtFRybRLyWJYxDI6yDWngx4oJGtq+k0pu1Q9A2UZ7gPcSWjWXwEE2?=
 =?iso-8859-1?Q?0lL0cqbMwi3eM1n1ZrhcLnU0Cl0rteGiXLz4HNVqATCw7xWFiLrNvMcHu0?=
 =?iso-8859-1?Q?ENk9rcR76Uq/tEuZzo9GtrSahWmp45nQKAN0yy6gLn/vi+1PG6YtPPUjvH?=
 =?iso-8859-1?Q?5l7rrIZZmCkOllJHf0lr77n1YIHDVsJyHNNyfuYbpYruMGT2EbNGjg/MjZ?=
 =?iso-8859-1?Q?zYoNaEb99qq1awf9vPHpDjbvgJEOYoeqe5C3r21fhutNiJnFWkz6dHrqOq?=
 =?iso-8859-1?Q?Fh+M7RHdJfQPZsFPo6tynszDvzqdEbThWmqzBt/PDSHJhZakeJPZYXzZIg?=
 =?iso-8859-1?Q?IjR4XWp4pLVm+WjzsiKOOpGLW4SK9yB6XTLpF7SfI9xTB1K817kaqRPwka?=
 =?iso-8859-1?Q?HLmRk0jj+sx4BK9YjBAVtIViSodacDDFeVCWa5+UFK5jYyJl739ViUKjLt?=
 =?iso-8859-1?Q?DJdq1cDQ6STiPC3ATKgyu7H1/mHJMmnALs46TaGim7PL4hvrjJjTLCCvLG?=
 =?iso-8859-1?Q?bbuWeADebwyZgb4FI33j6x//NzIrpVIIfar9B4ppyYIaBMO45E41h3LRiA?=
 =?iso-8859-1?Q?k7eagvg99+suBU/nB2ZT1MAKCgnrWgok2ASyuLgf9j0/waaLjsvt6+I2bW?=
 =?iso-8859-1?Q?7zOl7918s+0sOyPH/mewXhRPncG58tQXC7dNzpzrDnaYDQZiiuEgXXCF9i?=
 =?iso-8859-1?Q?ijqlxIxAIlkWaO20Z+9HE2xidBLsbmlmSOIRkwno7/zIWM1AX+QdvcF7FB?=
 =?iso-8859-1?Q?9kUzA1O85y4nlrS4Cbmw5TcIv+aEC84hIXm5pzoo2ZDxxnkvxJMXVbw+Nn?=
 =?iso-8859-1?Q?zXr3kkaxEzKdZRdeWbmwp04ilU7f7XWmgLP5FlJ3g=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PjwMGwryODJS6WcwIgQFSyE9nD+0Qts9103qDWTJSnwE8TLAtdcR8RCISr?=
 =?iso-8859-1?Q?jyxZLyoZFr5/se7h7/pU/ZnhEoB26Nn17jW72ZvfbKnj+ejEkgUXUFFbYx?=
 =?iso-8859-1?Q?tFF88e/yxoLfwVbg8Ih+6ExC10L4ElHmXcGdIO87SCpLF3n8H/rfDGLftK?=
 =?iso-8859-1?Q?tUb///+RkPjM0qlgbWDF/XW6exzXbW4RdGIHyDyOCqByZP9TXEbJ0+Bgc2?=
 =?iso-8859-1?Q?vJuW8u+ef0BCVGJQMP9syOsHeWrA2YiRCQ+cmhvRt0Iz9g/J303x58DrY5?=
 =?iso-8859-1?Q?5Nb2k3ZLWU9JXNNMdB5L/nzbSxMaTBfhNJqGV+W/SqknRPRUWKWX1Qh0Hy?=
 =?iso-8859-1?Q?6W1X0GOao+4VnCAeAOBC1i8nYXga3CC36EEoMQQ5Jg74qbuVguZAUbgZki?=
 =?iso-8859-1?Q?A/q7S9kjJpho76X3OLzrOR6lp3aFNki4aICrwjz/fNmUuVYI8vXezVOnh8?=
 =?iso-8859-1?Q?wAzjRqXFaeQXbjAQy4XTd9m2IqE2bld4NDpFSILI6v3Vi4ghuY09hjbAIE?=
 =?iso-8859-1?Q?z9TLpedfPEM6NdUglwCKnGp1ZktYU0XVkokgPwnEyCollE1Ijaix3/lkDP?=
 =?iso-8859-1?Q?ScozS2tsX2eWKjBX0fIAhqWLYf1B+gf5ZZMzRmEhcneTGHeRzbt0fYROjB?=
 =?iso-8859-1?Q?sU7ZK0PB96zG53VvuCSzjn7F1L4afZwXfv7cS4HJC37Z2dMGabFsOmZ99z?=
 =?iso-8859-1?Q?KM7qcmxZ7bO1SY8FtGJY0ulXR8I6NUVkQFb6h13PIR8JSy8hypmSWWSXt7?=
 =?iso-8859-1?Q?JtipLUbMCIsSQFyLgFP8taZwlMNMhD3/FCf7rB4MP8iD3FaH23bT3PGvgt?=
 =?iso-8859-1?Q?lx0m7LYLW1daS/1z9N54GQuFyt3ZSUdzA618EfmkpMAA119m1Ml0YxzwwC?=
 =?iso-8859-1?Q?LxLG5H3aMnpI67SGkIibcXCyx3PCWC3MKQ/Lw5VRNHC8LJ+05hx3KyR1jy?=
 =?iso-8859-1?Q?hrzA4T6MhLW5FGVZhc+I0bFH8d2v239PL16E/R9qzZVyPK3529RcPiKl3P?=
 =?iso-8859-1?Q?+yzLbpa/dbKDgW6VU6evhNn9AEOJ8yOPm/zC4nSYHAKx2JkcsSIHlSBean?=
 =?iso-8859-1?Q?VMtZvgR0HR4FAQ+616jWuhQXannVRN7g0BxHi3//5bNRQAdU/F4tMwxrsm?=
 =?iso-8859-1?Q?PbyZ1NdNeZc309Onu748BMoTYbrrj9SSuWFWyZKOhmohaPOF1HT6Hy2wWB?=
 =?iso-8859-1?Q?UYm94WV9EPMW0p1m8xJXqYuCvsa6WuRvDv4uoB9BK75sIoKRvnGa2HtRAB?=
 =?iso-8859-1?Q?rQaoPsU+atCyZYMHR/kkNFIfDhpxVltC1pWtCbY57RD3dE9N0UYiEM1jt8?=
 =?iso-8859-1?Q?A3dboyPOsDcpXJMX44GywCw+0QQC1nQe9/+KIhCbGYMIfHij9Zdmq3sYxL?=
 =?iso-8859-1?Q?vZzR6vm5LP1Mhf0kHCSOm3QGrdOA98kK2G/61zSlDMtqY6+dUs6z1KTquV?=
 =?iso-8859-1?Q?rA7T1uLaw+1gxclL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUZPR04MB9265.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: acdc86dc-edd9-427c-9ae2-08de81132feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 15:14:14.1002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7254
X-Mailman-Approved-At: Sun, 15 Mar 2026 11:20:58 +0000
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

[Why & How]=0A=
=0A=
On laptops with LPDDR5 modules, underflow can be observed.=0A=
It's unclear why it only occurs on specific desktop contents. However,=0A=
increasing enter/exit latencies by 1us seems to resolve it.=0A=
=0A=
Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/5065=0A=
Signed-off-by: Zhenzhe Zhang <zhenzhe.zhang@outlook.com>=0A=
---=0A=
 .../display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c   | 16 ++++++++--------=0A=
 .../drm/amd/display/dc/dml/dcn314/dcn314_fpu.c   |  4 ++--=0A=
 2 files changed, 10 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c=
 b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c=0A=
index 0cb37827a..7a910cc6d 100644=0A=
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c=0A=
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c=0A=
@@ -450,32 +450,32 @@ static struct wm_table lpddr5_wm_table =3D {=0A=
 			.wm_inst =3D WM_A,=0A=
 			.wm_type =3D WM_TYPE_PSTATE_CHG,=0A=
 			.pstate_latency_us =3D 11.65333,=0A=
-			.sr_exit_time_us =3D 30.0,=0A=
-			.sr_enter_plus_exit_time_us =3D 32.0,=0A=
+			.sr_exit_time_us =3D 31.0,=0A=
+			.sr_enter_plus_exit_time_us =3D 33.0,=0A=
 			.valid =3D true,=0A=
 		},=0A=
 		{=0A=
 			.wm_inst =3D WM_B,=0A=
 			.wm_type =3D WM_TYPE_PSTATE_CHG,=0A=
 			.pstate_latency_us =3D 11.65333,=0A=
-			.sr_exit_time_us =3D 30.0,=0A=
-			.sr_enter_plus_exit_time_us =3D 32.0,=0A=
+			.sr_exit_time_us =3D 31.0,=0A=
+			.sr_enter_plus_exit_time_us =3D 33.0,=0A=
 			.valid =3D true,=0A=
 		},=0A=
 		{=0A=
 			.wm_inst =3D WM_C,=0A=
 			.wm_type =3D WM_TYPE_PSTATE_CHG,=0A=
 			.pstate_latency_us =3D 11.65333,=0A=
-			.sr_exit_time_us =3D 30.0,=0A=
-			.sr_enter_plus_exit_time_us =3D 32.0,=0A=
+			.sr_exit_time_us =3D 31.0,=0A=
+			.sr_enter_plus_exit_time_us =3D 33.0,=0A=
 			.valid =3D true,=0A=
 		},=0A=
 		{=0A=
 			.wm_inst =3D WM_D,=0A=
 			.wm_type =3D WM_TYPE_PSTATE_CHG,=0A=
 			.pstate_latency_us =3D 11.65333,=0A=
-			.sr_exit_time_us =3D 30.0,=0A=
-			.sr_enter_plus_exit_time_us =3D 32.0,=0A=
+			.sr_exit_time_us =3D 31.0,=0A=
+			.sr_enter_plus_exit_time_us =3D 33.0,=0A=
 			.valid =3D true,=0A=
 		},=0A=
 	}=0A=
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c=0A=
index df9d50b9b..37c760fbb 100644=0A=
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c=0A=
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c=0A=
@@ -148,8 +148,8 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc =
=3D {=0A=
 		},=0A=
 	},=0A=
 	.num_states =3D 5,=0A=
-	.sr_exit_time_us =3D 16.5,=0A=
-	.sr_enter_plus_exit_time_us =3D 18.5,=0A=
+	.sr_exit_time_us =3D 17.5,=0A=
+	.sr_enter_plus_exit_time_us =3D 19.5,=0A=
 	.sr_exit_z8_time_us =3D 268.0,=0A=
 	.sr_enter_plus_exit_z8_time_us =3D 393.0,=0A=
 	.writeback_latency_us =3D 12.0,=0A=
-- =0A=
2.53.0=0A=
