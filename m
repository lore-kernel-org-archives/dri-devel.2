Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB45606BABD
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fXaeiuyM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3FB910F613;
	Tue, 27 Oct 2026 15:01:15 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013055.outbound.protection.outlook.com
 [40.107.162.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C5F10F613
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zbwcmn3ZqPInKUktgzzNbc51H6RgRpg4JFRTRFGFS09GMA39OIMPRfZIAs3TecYdwqs6X9JOTXD23DmEqGrt7f618RftxHkYQkUjJLcRE7v5jpNa1mGbVsewI96Sjc3mam4ipytMb7EPnB2B5XV2N0K/+juNnUw02GKpZ+OAFLoGA7kWxaGXe7JkLvMcyEXPRaYNCQ+JS24X8mbHsA+7WDkOQjOzZ4gLCuFjZhxcCCNPpw5HLcUnQVmdVLGSD/sZH/C1i7evEDiVqXaD17YQmn68g3GPead2aS6mhUDjy23vuqp31wZZ9zZ8My/PPvXHl4a30fBS1vs5qDjYuOlnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAeZf6Lo912oXpD4ocDURHS7p4gYhXWvm5B3ePlNJlg=;
 b=I11gTNd5+u0blfUjNilFvNFs1s97d5vqa2i4mo7z4KouJ5XwUs9bFD/9etb9W0Sf4tSxMHsSSKG1nKTpHeAx+nIwL5ZzZGR4SPdTreLTxNzZe0t1hhQagcmbljkk3amUxCuJdyEa35C3FhDMl2SocONRyu8vFNrK+25Bu/4pG1NbPGizV2BuaFA+55iRTZ0JMEJ2smPUIDGuVz96MER80BACfKlzdH7VUxYXEQhhUNZxot/ccNyAFn+MCZbXWM0Hyha/722Y1M7Jexgh0eqFt0+fFF2fuh+mILAaipuph7lUAgpXoiOOyusEQgAJMGVkHmj+SUo2Mtoo8R9A+3DnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAeZf6Lo912oXpD4ocDURHS7p4gYhXWvm5B3ePlNJlg=;
 b=fXaeiuyM2wdl+JPGL6s1ghHEZi6r4JOyfxxQbLLjmVltZ3juYNJTNEYN35qeU3fXPg0E9GocU0JUM38EU52O1Ub2NEgeYnrqBzRkTK+3TuWg8biRRoX26EEWV+fVOtHukpBkWx/3L2wKIhcDrAINJ48zZSlos0rZmXKT2gKRj7zYhOnFF4zdbvp++7WC/tq9zoK6G36XVuGa/auCF1b5hJxsA7Y2qffy2HlFsN/VHDb8TjsCRYLxmHHR56d2kR5r/qm2uMeCzOrNJ2k9gWNZy9LU/3DPy8M/wDmNBOwIUAhi5U/3dwMc93r/swx5Nhh2d8eElDfyG0nLhZPqyI89Ww==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU7PR04MB11162.eurprd04.prod.outlook.com (2603:10a6:10:5b3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:01:01 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:01:01 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v5 0/7] display: lcdif: imx: add display support for
 imx8dxl and imx8qxp
Date: Tue, 27 Oct 2026 11:00:52 -0400
Message-Id: <20261027-dxl_lcdif-v5-0-3a974e4b94b2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKS84GoC/1XNywrCMBQE0F+RrI0kN48aV/6HiORxqxFtpdFSk
 f67qYrG5cCcmQdJ2EVMZDV7kA77mGLb5KDmM+IPttkjjSFnAgw0q5ihYTjtTj7EmgbtXXDWG6g
 dyf1Lh3UcXlub7Tunmzuiv04DU+MQ07Xt7q+znk+9zy6XxW7PKaO60twurVYG3LoZLgvfnsm02
 kPpVOkgu2ArUykNWmj8d+LrOANWOpGdDd5Ime+Qy38nSydKJ7OTFpfCKCsdiJ8bx/EJgQOfO1o
 BAAA=
X-Change-ID: 20260709-dxl_lcdif-d6cbdbac92fb
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793113256; l=2687;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=guD3Mz8enV33Z5jb/nJPzfgIo07UdyUa5ukHlKC0WI4=;
 b=9O/JZkRpfz+pHgJLNoLxVF7yf4a9h2EddnmLWHMPyeiKMlz7m6IRUiAr4xzIK5oPpppLt5OJC
 Fzg3wY9kfOKBPdVZQpjNT10lZWyyVGASA3bxgqKzsXKh3r74meORR7w
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: DS7PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:8:55::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU7PR04MB11162:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b3898c-f8be-4546-0189-08df343b1d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|23010399003|7416014|261026140227099003|11063799006|921020|56012099006|261009223027099003|261022105027099003|261021121427099003|10067099003|261021123027099003|18002099003|261026121527099003|3023799007;
X-Microsoft-Antispam-Message-Info: 3HrbEiwsmBj+iNUwugqE/vo1r6ujr/lfSdcvY7hdSivhjjjMRqVGcGZEuMLj/LTkIrdOjGblmuPSda2nG7aGNaq6VEmnklf5F1vb4mD+7yPdsSeozJwjz2qtoP9PcpDih3ETZwhyFlzrm/HrVl++4so0ucRfuajkcfXsAswcnYVb9ZHuKkq2Rck9UF40f7zOR/hFAz3D/UT+xfgH0jwDb8P96TwzLMCj2qjyrnynV4sAFR7aWV9a9lYgjUhNBEMcQopOyVKeeXQ+poGDSBdZ4msDvsP7NjScEakaVjOky+tQGOA1nVP/cg5Fw92RminGyH4UHnz63nu3GDQ1966qahDz8T1WK09pl66fMnHs/T/cTUrq2aRQQuywSbZaM3p0am/gVdjwC3K1HwfBIelvshgaQyg1DXRTakevA0TfUEKHCOhQ6HFHj8k+zsekFWx50np/vSPAzvYtjMzRbX/8ZxJB54IPQkqUV1cvrymKWo5RbEL6LTGAdQ/wnzcEeGXNtFfMVbQf4bZOe4RMb5tet8blt685lyPL1r5KtyujFff06OCza9I+hez0ohgbHKxIwzFfAyM2/xZ0b3dg9x4K8/ga2fOnFPPdWtCN00pJs3gdFH/S0RrkGEhbqTkkbRuh4e5J8WwULEyY1P8goZp+35ulXBiVAtkYwZv7Rfk55IA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI3PR04MB12438.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(7416014)(261026140227099003)(11063799006)(921020)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(261021123027099003)(18002099003)(261026121527099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cThKclRJR1Vva1hydTZmakdMUEdxemNqcGJ1aE1NWUxWY2orbk8raFBqUHlZ?=
 =?utf-8?B?cEY5RGNEUExXUStrUEYrWWdpWkVJUTNlVVZ1MWtuTjBURTVJSnJnMS8zZHdt?=
 =?utf-8?B?L1NReEtKekJHbFNjeFZGMmI0d3p2d1lrUDlkNm5LbUdwdVo4S0VJZnZNTCtS?=
 =?utf-8?B?TFMvbllrSzRTY1VZK1FrdHJZQkJUTDVCVjlVS2FzQ3FvcXFjNUVoMEpLQkNZ?=
 =?utf-8?B?T3BrenQvM3d1T1BxcFVkN2IzTWNSV3BueEdUY09zRU1jaVFULzh3NXhFTDVL?=
 =?utf-8?B?dlZsbXNpb1BNRitTVkRmelpIQXYrMlIxVTJpb2xQKzBJWEtaM0xYV0YrZVJU?=
 =?utf-8?B?MjNjeDFuNFN5MkR6NXRUWW1NY0JLMU1rcEZRTkVCM29SdXk5aTVOTVY1WXlr?=
 =?utf-8?B?NGJqZ2tONDJIV2FKWkRvOUNKbkhRd2dQbnVZVTliSlEwTXBuaHJheDZEcDEz?=
 =?utf-8?B?OVp6Nzg5WDk1dTE0eWRMNjR6U09iSXl0L3hQVlYvR2JVK0N6ZHhRVXdhWFFR?=
 =?utf-8?B?MTBpc3BCQTBUamRnaUNWd0NEQVVvQjVBNGVsV001TlRLWW5qRDB4Y2pPQWdj?=
 =?utf-8?B?NW8rdGJORXJjZTNkVGJmd0M1RGZvcU5QeC9kU0lmY2ZXaDBjRzRLWFlOSnJD?=
 =?utf-8?B?SDF6TE5LTSttYVdoeG5CdzI5Ui8yWThpSlYwYnFHWmdOWm8wYk1XbnMvdU93?=
 =?utf-8?B?OEVQQXczU3p3SW95Z3BIUERTMy9seW9KaXpHM2ZLMlFXcGlHNStibGdIVVdJ?=
 =?utf-8?B?b21lUnpOdlhBUXBreFNJQ2tVa0h2elVObTVodUJPWWRIci9RSU1UdXROODM3?=
 =?utf-8?B?Zzl2OFBPa2hKckRKYkVtblN0bDMrSSt4QW1WVGlVVXF2M1lNMkJianpNMXBY?=
 =?utf-8?B?b095TjlPcDNYSUYzb3JzNkZoNld5dkpwTlhyNG54dXcxeXpNbjdrNzJ1R1Vo?=
 =?utf-8?B?bUR5TG9WY0ZWYUl1VmlQaHNjMWlxbGJLeUt6L0FWNFl3Qlp0OEN2L2dzcE9W?=
 =?utf-8?B?RmJIRk1rSHE1elUzSHlBQ25DcFE2dW80VDMzdlhZT09sT3U4aStVZ0cyeEpz?=
 =?utf-8?B?b1RNZnMvdjh6aUZWcUVsUmgwMElMVDUzSUo3ZkFCQm80MStidG1SM3M0ZXVI?=
 =?utf-8?B?MS80UCtyK1FHWVBqQldqNDQrdDUwU2QyR1hibFl3bU1GVEZiQm9aZzdSK2pR?=
 =?utf-8?B?VE0wOElzQXhuakxqOW5MRXBCdTI0UTdqc0ZqRzdCbWQzb3NQSTQyclNBOVJp?=
 =?utf-8?B?M1lDQUVob3NteG5OSUlDekNlZWNTNWI5ZXFJdWQ1UVdlQ2VOZGRoLzNKaXgv?=
 =?utf-8?B?VXlDUHlwRjJwYTBsdXBpbnJBNFpRbG03ZWJRcUtzU1pBTE5TdHBObUIvWk5J?=
 =?utf-8?B?R1p3L3RSaGZUc1hJQjYrUGJFdWNaN215QStVUWZqdmhid21YeHBCZFg1R3Qr?=
 =?utf-8?B?bC8weVhNUFhtWk52OXhHT2lwNi9PbnpPMUhjRS8rVVR3aVl3aEtGL1pxeVVw?=
 =?utf-8?B?MnlIMjBJejMzVjRVdEVXWWtQRVpzU0VJSG9GeUhDcXZJRnZ4T1l3OTdzYkVY?=
 =?utf-8?B?VDFpZ25uSkpNU3Y1MmpTaEg5WmJSWDFVSHV1WStWY0dyV00wS2w2L3ZnTXRp?=
 =?utf-8?B?em5QUTh1cVNHdTZjZkVhcGNDeHFVZlVhN0RaZ1lwZU9BVFZVVnY4VmZLa3Y1?=
 =?utf-8?B?dWx4a2JqS2ZYYS9KRUFsaGRnaXVudUxnYjlPczVpVXpHU3pTY2kzcGM2SXNz?=
 =?utf-8?B?YW1CVDJNaWJnRGlldGNoeWtWRUt4RERia1JBV1dIK3NxakRsMHNNejg2QjFp?=
 =?utf-8?B?eU84eUt1RFNtSzVtcDVXVEtjbTBRdE5GeVp5S2VzL3VvVTN3NGhxc2hUbFdi?=
 =?utf-8?B?SWFnQTlJSU11bmNGRmlUb1ArdVhWenB1UDJyR1JsRFBlK2tiMWk4OTF6ZXk1?=
 =?utf-8?B?a1Y5b3BNcG5oeGxXcUdacHl2UXZZNG9HUGpYNHRYamJFZndUMnkwN0J0Q3U5?=
 =?utf-8?B?VUZmNmlLU2ZwUVdNVDkyczlmUmo1dEk0b0w5SGJndU1IMFJlb05DK3JxNG12?=
 =?utf-8?B?amVKTmg3UXl3bWRCNnFQSTVzRS8wTS9maklrenA0QWVjUXYzaTZvZ2dxNTBj?=
 =?utf-8?B?a0l0QkNwU2o3cFdRVzFOS0dvcHc5T2YyWDNLREYwTldENGdXZGNvaU5vVWFU?=
 =?utf-8?B?ak1iejlKR1lwbDl4MjRNTWd0WWNUVk1WUWVZc05xWGZ4YzJOeTVBYTJ2Vm9W?=
 =?utf-8?B?YWRnTC8vTXJtR2JXRWgyZ1g1T2FTYk1oUnVtUG9hRVJoWkhWRUFSVFZyelJJ?=
 =?utf-8?B?NS9JRnVwMjB1bUZYRlFoYzMxaE1NeHZ0dUdvNUFmaFV1M0RGbWdsNnFSaGJp?=
 =?utf-8?Q?V433GG+HeJhOhxvL3UAWx6MedgIOWD9ICjLWV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b3898c-f8be-4546-0189-08df343b1d92
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:01:01.4634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSrBS3DpzLBzk0O9/yeXDr0gz2mLLYiym74coO3J06+7JMZQMfazMoQTwsToO9BV60eRuFlEc4egC/X5DreMVLyZuJ7+11t0nTgMV+5WLTBD2z6Ma14zb827My+8DbqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11162
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

i.MX8DXL and i.MX8QX support LCDIF, which is compatible with i.MX6SX.

- Update lcdif binding doc to support front compatible string:
fsl,imxqxp-lcdif and fsl,imx8dxl-lcdif
- Update simple pannel binding doc and driver to support waiken,101wx001
- update chip dts to support lcdif ip
- add overlay file to enable lcd panel waiken,101wx001 and lcdif
- use onboard pinmux "pinctrl-multiplexer" for on board signal switch

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- tune commit message at patch 3 and pick liu ying's reviewed-by tags.
- Link to v4: https://patch.msgid.link/20261023-dxl_lcdif-v4-0-4ae8395a4b23@nxp.com

Changes in v4:
- collect kryz and liu ying's ACK tags
- add wct surfix
- add idle-state = <1> to mux-controller.
- Link to v3: https://patch.msgid.link/20261020-dxl_lcdif-v3-0-adc944659e14@nxp.com

Changes in v3:
- add bus-width = <18>
- add lcd panel information at dtb file.
- detail see each patch's change log
- Link to v2: https://patch.msgid.link/20260715-dxl_lcdif-v2-0-da797562636e@nxp.com

Changes in v2 (fix sashiko reported problem):
- add power domain required for binding
- fix 136 height
- add acm patch to cleam MCL clock output pin
- remove iomux hog in overlay file
- Link to v1: https://patch.msgid.link/20260714-dxl_lcdif-v1-0-6761a8a6592b@nxp.com

---
Frank Li (7):
      dt-bindings: lcdif: add compatible string for i.MX8QXP and i.MX8DXL
      dt-bindings: display: simple: Add waiken,101wx001-wct
      drm/panel: simple: Add Waiken WKS101WX001-WCT panel support
      arm64: dts: imx8-ss-dma: Add lcdif support for i.MX8QXP and i.MX8DXL
      arm64: dts: imx8dxl-evk: Add onboard GPIO mux controller
      arm64: dts: imx8dxl-evk: Move ACM MCLK pin to ACM pinctrl
      arm64: dts: imx8dxl-evk: add lcdif overlay

 .../devicetree/bindings/display/fsl,lcdif.yaml     |   6 ++
 .../bindings/display/panel/panel-simple.yaml       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |  29 +++++
 .../freescale/imx8dxl-evk-lcdif-101wx001-wct.dtso  | 119 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      |  92 +++++++++++++---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi |  11 ++
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   |   2 +
 drivers/gpu/drm/panel/panel-simple.c               |  31 ++++++
 10 files changed, 284 insertions(+), 13 deletions(-)
---
base-commit: c27e4587a73de339f2d9f1304c913413055ed408
change-id: 20260709-dxl_lcdif-d6cbdbac92fb

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

